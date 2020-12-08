#!/bin/bash
data=$(jq .comment.user $GITHUB_EVENT_PATH)
echo $data
curl -X POST -H 'Content-type: application/json' -d '{"text": "tvar`", "blocks": '"$data"'}' $ENV_SLACK_WEBHOOK
