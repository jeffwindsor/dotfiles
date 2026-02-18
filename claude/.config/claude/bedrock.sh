#!/usr/bin/env bash

# CJ Bedrock backed Claude session
#   script uses a personal access token (https://developers.cj.com/account/personal-access-tokens)
#   to obtain AWS credentials from operations console API and bootstrap a claude bedrock session

if [[ -z "$CJ_PAT" ]]; then
  # Keychain lookup
  CJ_PAT=$(security find-generic-password -a "$USER" -s "cj-pat" -w 2>/dev/null)

  if [[ -z "$CJ_PAT" ]]; then
    echo "personal access token not found environment variable nor in macOS Keychain"
    echo "  Store it permanently in Keychain with: "
    echo "  security add-generic-password -a \"\$USER\" -s \"cj-pat\" -w \"your-token-value\""
    echo ""
    read -rp "Please enter a personal access token: " CJ_PAT
  else
    echo "personal access token obtained from macOS Keychain"
  fi

fi

echo "Fetching AWS credentials..."

if ! RESPONSE=$(curl -s 'https://4ybonx0pcf.execute-api.us-east-1.amazonaws.com/prod/vend-creds' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H "authorization: Bearer $CJ_PAT" \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'origin: https://operations.prod.cj.com' \
  -H 'pragma: no-cache' \
  -H 'priority: u=1, i' \
  -H 'referer: https://operations.prod.cj.com/' \
  -H 'sec-ch-ua: "Not;A=Brand";v="99", "Google Chrome";v="139", "Chromium";v="139"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: cross-site' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36' \
  --data-raw '{"id":"354793041154","role":"developer","duration":43199,"reason":"Access dev account"}'); then

  echo "Error: Failed to make HTTP request"
  exit 1
fi

if ! command -v jq &>/dev/null; then
  echo "Error: jq is required but not installed"
  exit 1
fi

echo "Parsing response..."

ACCESS_KEY_ID=$(echo "$RESPONSE" | jq -r '.credentials.AccessKeyId // empty')
SECRET_ACCESS_KEY=$(echo "$RESPONSE" | jq -r '.credentials.SecretAccessKey // empty')
SESSION_TOKEN=$(echo "$RESPONSE" | jq -r '.credentials.SessionToken // empty')

if [ -z "$ACCESS_KEY_ID" ] || [ -z "$SECRET_ACCESS_KEY" ] || [ -z "$SESSION_TOKEN" ]; then
  echo "Error: Failed to extract credentials from response"
  echo "Response was:"
  echo "$RESPONSE" | jq .
  exit 1
fi
echo "saving to /tmp/aws.dev.architects.creds"
echo -e "AWS_ACCESS_KEY_ID='{$ACCESS_KEY_ID}'\nAWS_SECRET_ACCESS_KEY='${SECRET_ACCESS_KEY}'\nAWS_SESSION_TOKEN='${SESSION_TOKEN}'" >/tmp/aws.dev.architects.creds

CLAUDE_CODE_USE_BEDROCK=1 AWS_REGION="us-west-2" AWS_ACCESS_KEY_ID="$ACCESS_KEY_ID" AWS_SECRET_ACCESS_KEY="$SECRET_ACCESS_KEY" AWS_SESSION_TOKEN="$SESSION_TOKEN" claude "$@"
