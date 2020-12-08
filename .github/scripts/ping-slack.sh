#!/bin/bash
test=$GITHUB_EVENT_PATH
data=$(jq . $test)
echo $test
echo $data
curl -X POST -H 'Content-type: application/json' --data $GITHUB_EVENT_PATH $ENV_SLACK_WEBHOOK
