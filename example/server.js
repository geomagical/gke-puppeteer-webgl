import puppeteer from 'puppeteer'
import express from 'express'
import serveStatic from 'serve-static'

async function main() {
  const browser = await puppeteer.launch({
    // Do not use this with untrusted pages. See the Puppeteer docs for information on setting up a user sandbox.
    args: ["--no-sandbox"],
    // Head-ful mode enabled so we can use X's GPU acceleration.
    headless: false,
    // Remove this line to reduce the output after you've confirmed things are working.
    dumpio: true,
    // Simulate a reasonably sized display.
    defaultViewport: { width: 1920, height: 1080 },
  });

  // Take a screenshot of the GPU diagnostics page.
  const page = await browser.newPage();
  await page.goto("chrome://gpu/");
  await page.waitForTimeout(1000);
  await page.screenshot({path: 'out/gpu.png', fullPage: true});
}

// Launch Puppeteer.
main();

// Run a web server so you can see the screenshot.
var app = express()
app.use(serveStatic('out'))
app.listen(3000)
