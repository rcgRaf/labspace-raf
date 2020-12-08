#!/bin/bash
data=$(jq .comment $GITHUB_EVENT_PATH)
echo $data
echo '{"text":"$data"}' | curl -X POST -H 'Content-type: application/json' -d @- $ENV_SLACK_WEBHOOK
