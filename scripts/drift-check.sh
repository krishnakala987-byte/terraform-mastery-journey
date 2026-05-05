#!/bin/bash

echo "Running Terraform Drift Detection..."

terraform init -input=false

terraform plan -detailed-exitcode -no-color > plan.txt

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  echo "No drift detected"
elif [ $EXIT_CODE -eq 2 ]; then
  echo "Drift detected!"
  cat plan.txt
else
  echo "Error running terraform plan"
fi
