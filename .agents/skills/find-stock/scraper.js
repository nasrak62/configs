const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');
const readline = require('readline');

// Configuration
const BASE_URL = 'https://finance.yahoo.com';
const OUTPUT_DIR = path.resolve(__dirname, '../../../stocks-info');
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
    '.btn.primary'
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
    } catch (e) {}
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
  // For all pages, wait for body to have content
  await page.waitForFunction(() => {
    const body = document.body;
    return body.childElementCount > 10;
  }, { timeout: 30000 });
  
  // Additional sleep for AJAX content
  await new Promise(r => setTimeout(r, 2000));
}

async function scrapePage(page, url, ticker, pageKey) {
  let attempts = 0;
  const maxAttempts = 3;
  
  while (attempts < maxAttempts) {
    attempts++;
    try {
      console.log(`  🌐 Attempt ${attempts}: Navigating to ${url}`);
      
      // Use domcontentloaded instead of networkidle for AJAX-heavy sites
      await page.goto(url, { 
        waitUntil: 'domcontentloaded', 
        timeout: 120000 
      });
      
      // Wait for initial document load
      await new Promise(r => setTimeout(r, 2000));
      
      const title = await page.title().catch(() => null);
      if (title && title.length > 2) {
        console.log(`  ✓ Page loaded with title: ${title.substring(0, 50)}...`);
      }

      await acceptConsentDialog(page);
      
      // Wait after consent
      await new Promise(r => setTimeout(r, 2000));
      
      await handleExpandAll(page);

      if (FINANCIAL_PAGES.includes(pageKey)) {
        await handleFinancialTabs(page, pageKey);
      }

      await waitForDynamicContent(page, pageKey);

      // Additional sleep to allow AJAX content to load
      await new Promise(r => setTimeout(r, 3000));

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
        try {
          await page.reload({ waitUntil: 'domcontentloaded' });
        } catch (reloadError) {
          console.log(`  ⚠️  Reload failed: ${reloadError.message}`);
        }
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
    args: [
      '--no-sandbox',
      '--disable-setuid-sandbox',
      '--disable-blink-features=AutomationControlled',
      '--disable-web-security',
      '--disable-site-isolation-traces'
    ],
    headless: false
  });
  
  const context = await browser.newContext({
    viewport: { width: 1920, height: 1080 },
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
  });
  
  await context.addInitScript(() => {
    Object.defineProperty(navigator, 'webdriver', { get: () => undefined });
    Object.defineProperty(navigator, 'language', {
      get: () => 'en-US'
    });
    Object.defineProperty(navigator, 'languages', {
      get: () => ['en-US', 'en']
    });
  });
  
  const page = await context.newPage();
  await page.goto('about:blank', { waitUntil: 'networkidle' });

  console.log(`\n📈 Scraping stock: ${ticker}`);
  console.log('=' .repeat(50));

  try {
    for (const [key, pattern] of Object.entries(PAGE_PATTERNS)) {
      const url = BASE_URL + pattern.replace('{ticker}', ticker);
      console.log(`\n🌐 Visiting: ${url}`);
      await scrapePage(page, url, ticker, key);
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

// Interactive mode for CLI
async function interactiveMode() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  console.log('\n📈 Yahoo Finance Stock Scraper');
  console.log('=' .repeat(50));
  console.log('Enter a stock ticker symbol (e.g., AAPL, TSLA):');

  const answer = await new Promise(resolve => rl.question('> '));
  rl.close();

  const ticker = answer.trim().toUpperCase();
  if (!ticker || ticker.length < 2) {
    console.log('❌ Please enter a valid ticker symbol (at least 2 characters)');
    process.exit(1);
  }

  await scrapeStock(ticker);
}

// Run interactive mode
if (require.main === module) {
  interactiveMode();
}

module.exports = { scrapeStock, scrapePage, handleExpandAll, handleFinancialTabs };
