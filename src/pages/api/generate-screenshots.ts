import type { APIRoute } from 'astro';
import puppeteer from 'puppeteer';
import archiver from 'archiver';
import { Readable } from 'stream';

export const POST: APIRoute = async ({ request }) => {
  try {
    const { pages } = await request.json();
    const baseUrl = new URL(request.url).origin;

    const browser = await puppeteer.launch({
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage']
    });

    const page = await browser.newPage();
    await page.setViewport({ width: 1920, height: 1080 });

    const screenshots: { name: string; buffer: Buffer }[] = [];

    for (const pagePath of pages) {
      try {
        const url = `${baseUrl}${pagePath}`;
        await page.goto(url, { waitUntil: 'networkidle0', timeout: 30000 });

        // Wait a bit for any animations to complete
        await page.waitForTimeout(1000);

        const screenshot = await page.screenshot({
          fullPage: true,
          type: 'png'
        });

        const pageName = pagePath === '/' ? 'home' : pagePath.replace(/^\//, '').replace(/\//g, '-');
        screenshots.push({
          name: `${pageName}.png`,
          buffer: Buffer.from(screenshot)
        });
      } catch (error) {
        console.error(`Failed to capture ${pagePath}:`, error);
      }
    }

    await browser.close();

    // Create ZIP archive
    const archive = archiver('zip', { zlib: { level: 9 } });

    // Add all screenshots to the archive
    for (const screenshot of screenshots) {
      archive.append(screenshot.buffer, { name: screenshot.name });
    }

    // Finalize the archive
    await archive.finalize();

    // Convert archive stream to buffer
    const chunks: Buffer[] = [];
    for await (const chunk of archive) {
      chunks.push(Buffer.from(chunk));
    }
    const zipBuffer = Buffer.concat(chunks);

    return new Response(zipBuffer, {
      status: 200,
      headers: {
        'Content-Type': 'application/zip',
        'Content-Disposition': `attachment; filename="bricswise-screenshots-${Date.now()}.zip"`
      }
    });

  } catch (error) {
    console.error('Screenshot generation error:', error);
    return new Response(JSON.stringify({
      error: 'Failed to generate screenshots',
      details: error instanceof Error ? error.message : 'Unknown error'
    }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};
