curl --request POST \
  --url 'https://kordsevillab.atlassian.net/rest/api/3/issue' \
  --user "harutghandilyan@gmail.com:$jira_user_token" \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
  "update": {},
  "fields": {
    "summary": "Main order flow broken taza ticket",    
    "issuetype": {
      "id": "10002"
    },
    "reporter": {
      "id": "557058:a2988925-cc50-4ed2-a2ab-f182a5a546ed"
    },
    "project": {
      "id": "10000"
    }
    }
}'
