const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

const BASE_URL = 'https://finance.yahoo.com';
const OUTPUT_DIR = path.resolve(__dirname, '../../stocks-info');
const BROWSER_EXECUTABLE = '/usr/bin/chromium';

async function scrapeQuotePage(ticker) {
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
      '--disable-web-security'
    ],
    headless: false
  });
  
  const context = await browser.newContext({
    viewport: { width: 1920, height: 1080 },
    locale: 'en-US',
    timezoneId: 'America/New_York',
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    geolocation: { longitude: -74.0060, latitude: 40.7128 },
    permissions: ['geolocation'],
  });
  
  await context.addInitScript(() => {
    Object.defineProperty(navigator, 'language', {
      get: () => 'en-US'
    });
    Object.defineProperty(navigator, 'languages', {
      get: () => ['en-US', 'en']
    });
    Object.defineProperty(navigator, 'userLanguage', {
      get: () => 'en-US'
    });
    Object.defineProperty(navigator, 'webdriver', { get: () => undefined });
  });
  
  const page = await context.newPage();
  
  console.log(`\n📈 Scraping ${ticker} quote page`);
  console.log('=' .repeat(50));
  
  try {
    const url = `${BASE_URL}/quote/${ticker}/`;
    console.log(`\n🌐 Visiting: ${url}`);
    
    await page.goto(url, { waitUntil: 'networkidle', timeout: 120000 });
    await page.waitForLoadState('domcontentloaded');
    await new Promise(r => setTimeout(r, 2000));
    
    const title = await page.title().catch(() => null);
    console.log(`Page title: ${title}`);
    
    // Handle consent dialog - try multiple selectors
    const consentSelectors = [
      'button:has-text("Accept")',
      'button:has-text("Accept all")',
      'button:has-text("Agree")',
      '.btn.primary',
      '#onetrust-accept-btn-handler',
      'button[onclick*="accept"]'
    ];
    
    for (const selector of consentSelectors) {
      try {
        const btn = await page.$(selector);
        if (btn) {
          console.log(`Found consent button (${selector}), clicking...`);
          await btn.click();
          await new Promise(r => setTimeout(r, 2000));
          break;
        }
      } catch (e) {
        // Try next selector
      }
    }
    
    await new Promise(r => setTimeout(r, 2000));
    
    const html = await page.content();
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const filename = `${ticker}_quote_${timestamp}.html`;
    const filepath = path.join(OUTPUT_DIR, ticker, filename);
    
    fs.writeFileSync(filepath, html, 'utf8');
    console.log(`\n✅ Saved: ${filename} (${(html.length / 1024).toFixed(2)} KB)`);
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  } finally {
    await browser.close();
  }
}

scrapeQuotePage('AMD');
