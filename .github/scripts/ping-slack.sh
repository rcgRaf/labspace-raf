#!/bin/bash
echo $GITHUB_EVENT_PATH

test=$GITHUB_EVENT_PATH
data=$(jq . $test)

echo $test
echo $data
curl -X POST -H 'Content-type: application/json' --data @test $ENV_SLACK_WEBHOOK
