"""Stack Overflow Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Top-voted Playwright questions
run = client.actor("Turboextract/stackoverflow-questions").call(run_input={
    "tags": [
        "playwright"
    ],
    "sort": "votes",
    "maxResults": 200
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("score"), item.get("views"), item.get("title"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
