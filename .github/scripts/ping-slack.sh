#!/bin/bash
echo $ENV_SLACK_WEBHOOK
sudo curl -X POST -H 'Content-type: application/json' --data '{"text":"Allow me to reintroduce myself!"}' $ENV_SLACK_WEBHOOK
