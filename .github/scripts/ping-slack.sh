#!/bin/bash
data=$(jq .repo.compare_url $GITHUB_EVENT_PATH)
echo $data
curl -X POST -H 'Content-type: application/json' -d '{"text": "tvar`", "blocks": ['"$data"']}' $ENV_SLACK_WEBHOOK
