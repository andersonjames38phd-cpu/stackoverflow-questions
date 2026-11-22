#!/usr/bin/env bash
# Stack Overflow Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~stackoverflow-questions"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Top-voted Playwright questions (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "tags": [
      "playwright"
    ],
    "sort": "votes",
    "maxResults": 200
  }'

# 2. Recent questions matching a keyword (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "tags": [],
    "searchQuery": "next.js hydration error",
    "fromDate": "2026-10-01"
  }'

# 3. Unanswered questions on Server Fault (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "tags": [
      "nginx"
    ],
    "site": "serverfault",
    "unansweredOnly": true
  }'
