#!/bin/bash
test=$GITHUB_EVENT_PATH
data=$(jq . $test)
echo $test
echo $data
cat $GITHUB_EVENT_PATH $ENV_SLACK_WEBHOOK | curl -X POST -H 'Content-type: application/json' -d @-
