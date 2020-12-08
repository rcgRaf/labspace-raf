#!/bin/bash
data=$(jq .comment $GITHUB_EVENT_PATH)
echo $data
echo '{"text":"Allow me to reintroduce myself!"}' | curl -X POST -H 'Content-type: application/json' -d @- $ENV_SLACK_WEBHOOK
