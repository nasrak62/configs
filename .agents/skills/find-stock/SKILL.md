---
name: find-stock
description: Navigate Yahoo Finance stock pages (quote, news, key-statistics, history, profile, analysis, holders, financials) and collect complete HTML from annual/quarterly tabs plus expand-all sections after full JavaScript load. Click consent buttons if needed. Uses Playwright script in ./scraper.js

compatibility:
  opencodemetadata:
    workflow: browser_automation
---
# What I do

## Navigation

- Navigate to target stock page (e.g., AAPL) or default to <https://finance.yahoo.com/>
- Handle consent acceptance dialogs using Playwright MCP if necessary

## Playwright Script Location

The automation script is saved at: `./scraper.js`

This script handles:
- Browser initialization and navigation
- Consent dialog acceptance
- Dynamic content loading with explicit waits
- Expand-all button detection and interaction
- Financial tab switching (Annual + Quarterly)
- HTML collection after full page render

## Pages to Scrape

Collect complete HTML from ALL of these sections with full JavaScript rendering:

## Save to

~/stocks-info/{ticker}/

## Main Quote Sections

1. **Main Quote Page**: /quote/{ticker}/
2. **News Tab**: /quote/{ticker}/news/
3. **Key Statistics**: /quote/{ticker}/key-statistics/
4. **History/Quote History**: /quote/{ticker}/history/
5. **Profile**: /quote/{ticker}/profile/
6. **Analysis**: /quote/{ticker}/analysis/
7. **Holders**: /quote/{ticker}/holders/

## Financial Data Sections (All Require Annual + Quarterly)

8. **Financials**: /quote/{ticker}/financials/
2. **Balance Sheet**: /quote/{ticker}/balance-sheet/
3. **Cash Flow**: /quote/{ticker}/cash-flow/

## Financial Data Handling**

For ALL financial data pages (/financials/, /balance-sheet/, /cash-flow/):

- Expand Annual tab if available
- Select Quarterly tab (bothAnnual AND Quarterly required)
- Wait for each tab's data to load

# Critical: Handle 'expand all' button on these pages before completion

# Load Sequence (Critical Order)

1. **Navigate** to target stock URL
2. **Accept consent** if dialog appears using Playwright MCP
3. **Wait for initial page load** (static content)
4. **Detect 'expand all' button**:
   - Check if element exists on current page
   - If found: wait for visibility, then click it
5. **For financials pages specifically** (/quote/{ticker}/financials/):
   - Click Annual tab if available
   - Select Quarterly tab also (both required)
   - Wait for each tab's data to load
6. **Wait for JavaScript async load**: Ensure all dynamic content rendered
7. **Collect complete HTML**: Return fully rendered page source

# Page-Specific Notes

- **/news/**: May have loading indicators, wait until all news items loaded
- **/key-statistics/**: Stats populate dynamically, wait for completion
- **/profile/**: Company info loads async
- **/analysis/**: Analyst ratings load with charting library
- **/holders/**: Ownership data populates via JS
- **/financials/** (critical): Both annual AND quarterly tabs, expand all button present, multiple tables load sequentially
- **/balance-sheet/**: Same treatment as financials - both time periods, expand all if present
- **/cash-flow/**: Same treatment as financials - both time periods, expand all if present

# Return Format

Complete HTML content of fully rendered page including dynamically loaded data tables, news items, statistics charts, and financial tab contents.

## When to use me

Use this skill whenever you need to:

- Access fully loaded Yahoo Finance stock pages with dynamic content rendered
- Get annual AND quarterly financial data for comprehensive analysis
- Capture expand-all sections like quarterly breakdowns
- Extract complete HTML from quote tabs (financials, news, key-stats, holders, etc.)
- Handle consent dialog acceptance automatically

## Test Script

Run test with: `node ./scraper.js`  
- Capture expand-all sections like quarterly breakdowns
- Extract complete HTML from quote tabs (financials, news, key-stats, holders, etc.)
