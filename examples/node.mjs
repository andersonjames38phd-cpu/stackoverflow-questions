// Stack Overflow Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Recent questions matching a keyword
const run = await client.actor('Turboextract/stackoverflow-questions').call({
    "tags": [],
    "searchQuery": "next.js hydration error",
    "fromDate": "2026-10-01"
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.score, item.views, item.title);
}
