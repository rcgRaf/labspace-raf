#!/bin/sh
sudo curl -X POST -H 'Content-type: application/json' --data '{"text":"Allow me to reintroduce myself!"}' ${{ secrets.SLACK_WEBHOOK }}
