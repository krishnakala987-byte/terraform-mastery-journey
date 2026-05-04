#!/bin/bash

cd "$(dirname "$0")"

WEBHOOK_URL="YOUR_SLACK_WEBHOOK"

terraform init -input=false >/dev/null 2>&1
terraform plan -detailed-exitcode -no-color > plan.txt

EXIT_CODE=$?

if [ $EXIT_CODE -eq 2 ]; then
  MESSAGE="⚠️Terraform Drift Detected\n$(cat plan.txt)"

  curl -X POST -H 'Content-type: application/json' \
  --data "{\"text\":\"$MESSAGE\"}" $WEBHOOK_URL

elif [ $EXIT_CODE -eq 1 ]; then
  curl -X POST -H 'Content-type: application/json' \
  --data '{"text":" Terraform Error"}' $WEBHOOK_URL
fi
