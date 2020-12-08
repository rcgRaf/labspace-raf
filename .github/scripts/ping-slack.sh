#!/bin/bash
data=$(jq .comment $GITHUB_EVENT_PATH)
echo $data
echo "$(jq .comment $GITHUB_EVENT_PATH)" | curl -X POST -H 'Content-type: application/json' -d @- $ENV_SLACK_WEBHOOK
