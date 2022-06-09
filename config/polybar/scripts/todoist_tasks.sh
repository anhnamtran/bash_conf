#!/bin/bash
SECRETS_DIR="$HOME/.secrets"
FILTER="today | overdue | @waiting"
TODOIST_SECRET=$(test -f "$SECRETS_DIR"/todoist_api_token && \
                 cat "$SECRETS_DIR"/todoist_api_token)
if [[ -z "$TODOIST_SECRET" ]]; then
  exit 1
fi
curl -s -k -G -X GET \
  'https://api.todoist.com/rest/v1/tasks' \
  -H "Authorization: Bearer $TODOIST_SECRET" \
  --data-urlencode 'filter='"$FILTER" \
  | grep -c content
