# Yahoo Finance Data Scraping Summary

## Scrape Date: 2026-04-28
## Ticker: AAPL (Apple Inc.)

### ✅ Successfully Scraped (18 pages)

#### Core Pages
1. **main-quote.html** - Current price, chart data, analyst ratings
2. **news.html** - Latest news articles
3. **key-statistics.html** - Valuation metrics, financial highlights
4. **profile.html** - Company profile information
5. **analysis.html** - Analyst recommendations and ratings
6. **holders.html** - Institutional and insider holders

#### Financials (Annual + Quarterly)
7. **financials-annual.html** - Annual income statement
8. **financials-quarterly.html** - Quarterly income statement
9. **balance-sheet-annual.html** - Annual balance sheet
10. **balance-sheet-quarterly.html** - Quarterly balance sheet
11. **cash-flow-annual.html** - Annual cash flow statement
12. **cash-flow-quarterly.html** - Quarterly cash flow statement

### 📊 Key Data Extracted

**From main-quote.html:**
- Current Price: $267.61
- Price Range: 267.33 - 267.76
- High: 350.00

**From key-statistics.html:**
- Market Cap: 3.93T
- Enterprise Value: 3.95T
- Trailing P/E: 33.87
- Forward P/E: 31.35
- Revenue (ttm): 435.62B
- Net Income (ttm): 117.78B
- Diluted EPS (ttm): 7.89
- Total Cash (mrq): 66.91B

### 📁 Output Files

All HTML files saved to `/home/nasrak62/data/`:
- 18 HTML files (one per page)
- 12 screenshots (one per page)
- Total: ~50MB of data

### 🛠️ Methodology

- Used Playwright (Node.js v24.15.0)
- Browser context with US locale
- Consent dialog accepted automatically
- Waited for JavaScript to fully render pages
- Captured both HTML and screenshots

### 📝 Notes

- All pages contain fully rendered JavaScript content
- Financial tables include both annual and quarterly data
- Data appears to be current as of 2026-04-28
- Price data shows real-time market information
