#!/bin/bash
data=$(jq .action $GITHUB_EVENT_PATH)
echo $data
cat $data | curl -X POST -H 'Content-type: application/json' -d @- $ENV_SLACK_WEBHOOK
