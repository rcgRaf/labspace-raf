#!/bin/bash
echo $ENV_MESSAGE 
curl -X POST -H 'Content-type: application/json' --data '{"text":$ENV_MESSAGE}' $ENV_SLACK_WEBHOOK
