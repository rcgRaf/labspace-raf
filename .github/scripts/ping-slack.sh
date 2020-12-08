#!/bin/bash
data=$(jq .comment $GITHUB_EVENT_PATH)
echo $data
curl -X POST -H 'Content-type: application/json' -d "{'text': $(jq .comment $GITHUB_EVENT_PATH)}" $ENV_SLACK_WEBHOOK
