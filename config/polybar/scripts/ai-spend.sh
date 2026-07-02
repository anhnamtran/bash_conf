#!/usr/bin/bash
set -eu

PROXY_URL="${AIKEYS_PROXY_URL:-https://ai-proxy.infra.corp.arista.io}"
KEY_FILE="${AIKEYS_KEY_FILE:-$HOME/.secrets/aikey}"

extract_spend() {
	sed -n 's/.*"spend"[[:space:]]*:[[:space:]]*\([0-9][0-9.]*\).*/\1/p' | head -n 1
}

format_spend() {
	awk -v spend="$1" 'BEGIN { printf "$%.2f/$75.00\n", spend }'
}

get_spend() {
  api_key=$(tr -d '\r\n' < "$KEY_FILE")
  response=$(
    curl -sf --max-time 10 \
      -H "Authorization: Bearer $api_key" \
      "$PROXY_URL/key/info" 2>/dev/null || true
  )
  spend=$(printf '%s\n' "$response" | extract_spend)
  format_spend "$spend"
}

get_spend
