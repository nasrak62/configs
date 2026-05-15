const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

// Configuration
const BASE_URL = 'https://finance.yahoo.com';
const OUTPUT_DIR = path.resolve(__dirname, '../../stocks-info');
const BROWSER_EXECUTABLE = '/usr/bin/chromium';

// Page patterns
const PAGE_PATTERNS = {
  quote: '/quote/{ticker}/',
  news: '/quote/{ticker}/news/',
  keyStatistics: '/quote/{ticker}/key-statistics/',
  history: '/quote/{ticker}/history/',
  profile: '/quote/{ticker}/profile/',
  analysis: '/quote/{ticker}/analysis/',
  holders: '/quote/{ticker}/holders/',
  financials: '/quote/{ticker}/financials/',
  balanceSheet: '/quote/{ticker}/balance-sheet/',
  cashFlow: '/quote/{ticker}/cash-flow/'
};

// Financial pages that need both Annual and Quarterly data
const FINANCIAL_PAGES = ['financials', 'balanceSheet', 'cashFlow'];

// Helper functions
async function acceptConsentDialog(page) {
  console.log('  ⚠️  Detecting consent dialog...');
  
  // Try various consent selectors
  const consentSelectors = [
    'button:has-text("Accept")',
    'button:has-text("Accept all")',
    'button:has-text("Agree")',
    '[data-testid="accept-all"]',
    '[data-testid="accept"]',
    'button[aria-label*="accept"]',
    '.accept-all',
    '.accept-all button',
    '#onetrust-accept-btn-handler',
    '#onetrust-close-btn-sdk',
    'button:has-text("Accept All")',
    'button[onclick*="accept"]',
    '.onetrust-consent-sdk button',
    '.ot-sdk-button'
  ];
  
  for (const selector of consentSelectors) {
    try {
      const element = await page.$(selector);
      if (element) {
        console.log('  ✓ Found consent button, clicking...');
        await element.click();
        await new Promise(r => setTimeout(r, 1500));
        return true;
      }
    } catch (e) {
      // Try next selector
    }
  }
  return false;
}

async function handleExpandAll(page) {
  const selectors = [
    'button:has-text("Expand All")',
    'button:has-text("Show All")',
    '[data-test="expand-all"]',
    'button[aria-label*="expand"]',
    '.expand-all-button'
  ];
  
  for (const selector of selectors) {
    try {
      const element = await page.$(selector);
      if (element) {
        console.log('  🔍 Found expand-all button, clicking...');
        await element.click();
        await new Promise(r => setTimeout(r, 1500));
        return;
      }
    } catch (e) {}
  }
}

async function handleFinancialTabs(page, pageKey) {
  console.log('  💰 Handling financial data tabs...');
  const tabButtons = await page.locator('button, [role="tab"]').all();
  
  for (const button of tabButtons) {
    const text = await button.textContent().catch(() => null);
    
    if (text && (text.includes('Annual') || text.includes(' yearly'))) {
      console.log('  📅 Clicking Annual tab...');
      await button.click();
      await new Promise(r => setTimeout(r, 1500));
    }
    
    if (text && (text.includes('Quarterly') || text.includes(' quarterly'))) {
      console.log('  📅 Clicking Quarterly tab...');
      await button.click();
      await new Promise(r => setTimeout(r, 1500));
    }
  }
}

async function waitForDynamicContent(page, pageKey) {
  const waitPatterns = {
    news: 'article, .news-item, [class*="news"]',
    keyStatistics: 'table, [class*="stat"], .key-stat',
    history: 'table, [class*="chart"], .history-data',
    profile: 'div, [class*="profile"], .company-info',
    analysis: 'table, [class*="analysis"], .analyst-rating',
    holders: 'table, [class*="holder"], .ownership',
    financials: 'table, [class*="financial"], .financial-data',
    balanceSheet: 'table, [class*="balance"], .balance-sheet-data',
    cashFlow: 'table, [class*="cashflow"], .cash-flow-data'
  };
  
  const selector = waitPatterns[pageKey] || '*';
  await page.waitForSelector(selector, { timeout: 10000 });
  await new Promise(r => setTimeout(r, 2000));
}

async function scrapePage(page, url, ticker, pageKey) {
  let attempts = 0;
  const maxAttempts = 3;
  
  while (attempts < maxAttempts) {
    attempts++;
    try {
      console.log(`  🌐 Attempt ${attempts}: Navigating to ${url}`);
      
      // Navigate with better wait strategy
      await page.goto(url, { 
        waitUntil: 'networkidle', 
        timeout: 120000 
      });
      
      // Wait for DOM content loaded first
      await page.waitForLoadState('domcontentloaded');
      
      // Additional wait for JavaScript
      await new Promise(r => setTimeout(r, 2000));
      
      // Try to detect if page loaded successfully by checking for content
      const title = await page.title().catch(() => null);
      const bodyContent = await page.locator('body').innerText().catch(() => null);
      
      if (title && bodyContent && bodyContent.length > 50) {
        console.log(`  ✓ Page loaded with title: ${title}`);
      } else {
        console.log(`  ⚠️  Page title: ${title || 'N/A'}, content length: ${bodyContent?.length || 0}`);
      }

      // Handle consent dialog FIRST
      await acceptConsentDialog(page);

      // Small wait after consent
      await new Promise(r => setTimeout(r, 1000));

      // Handle expand all
      await handleExpandAll(page);

      // Wait for dynamic content
      await waitForDynamicContent(page, pageKey);

      // Get full HTML
      const html = await page.content();
      
      if (html.length < 100) {
        throw new Error('HTML content too small, retrying...');
      }

      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const filename = `${ticker}_${pageKey}_${timestamp}.html`;
      const filepath = path.join(OUTPUT_DIR, ticker, filename);
      
      fs.writeFileSync(filepath, html, 'utf8');
      console.log(`  ✓ Saved: ${filename} (${(html.length / 1024).toFixed(2)} KB)`);
      return;

    } catch (error) {
      console.error(`  ❌ Error scraping ${pageKey} (attempt ${attempts}):`, error.message);
      if (attempts < maxAttempts) {
        console.log(`  ⏳ Retrying in 5 seconds...`);
        await new Promise(r => setTimeout(r, 5000));
        // Reset page state - reload the page
        await page.reload({ waitUntil: 'domcontentloaded' });
        await new Promise(r => setTimeout(r, 1000));
      }
    }
  }
  
  console.log(`  ⚠️  Failed after ${maxAttempts} attempts for ${pageKey}`);
}

async function scrapeStock(ticker) {
  const tickerDir = path.resolve(OUTPUT_DIR, ticker);
  if (!fs.existsSync(tickerDir)) {
    fs.mkdirSync(tickerDir, { recursive: true });
  }

  const browser = await chromium.launch({
    executablePath: BROWSER_EXECUTABLE,
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
    headless: false
  });

  const context = await browser.newContext({
    viewport: { width: 1920, height: 1080 }
  });

  const page = await context.newPage();
  
  // Set up page options for better loading
  await page.route('**/*', route => {
    // Allow all routes, but log if needed
  });
  
  await page.goto('about:blank', { waitUntil: 'networkidle' });

  console.log(`\n📈 Scraping stock: ${ticker}`);
  console.log('=' .repeat(50));

  try {
    // Process each page pattern
    for (const [key, pattern] of Object.entries(PAGE_PATTERNS)) {
      const url = BASE_URL + pattern.replace('{ticker}', ticker);
      console.log(`\n🌐 Visiting: ${url}`);
      await scrapePage(page, url, ticker, key);
      
      // Small delay between pages to avoid overwhelming the server
      await new Promise(r => setTimeout(r, 3000));
    }

    console.log('\n' + '='.repeat(50));
    console.log(`✅ Scraping complete! Results saved to: ${tickerDir}`);

  } catch (error) {
    console.error('❌ Error during scraping:', error.message);
  } finally {
    await browser.close();
  }
}

scrapeStock('AMD');
