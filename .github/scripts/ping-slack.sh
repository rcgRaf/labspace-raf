#!/bin/bash
test=$GITHUB_EVENT_PATH
data=$(jq . $test)
echo $test
echo $data
cat $GITHUB_EVENT_PATH | curl -X POST -H 'Content-type: application/json' -d @- $ENV_SLACK_WEBHOOK
