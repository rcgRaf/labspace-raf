#!/bin/bash
echo $GITHUB_EVENT_PATH

test = $GITHUB_EVENT_PATH
data = @test

echo $test
echo $data
curl -X POST -H 'Content-type: application/json' --data data $ENV_SLACK_WEBHOOK
