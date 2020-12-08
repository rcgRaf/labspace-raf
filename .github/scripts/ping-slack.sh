#!/bin/bash
echo $ENV_MESSAGE 
Var

curl -X POST -H 'Content-type: application/json' --data @$GITHUB_EVENT_PATH $ENV_SLACK_WEBHOOK
