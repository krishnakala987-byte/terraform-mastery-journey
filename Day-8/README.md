# Terraform Drift Detection using GitHub Actions and Slack

## Project Overview

This project demonstrates a practical DevOps workflow for managing cloud infrastructure using Terraform. It focuses on detecting infrastructure drift by comparing the desired configuration with the actual state in AWS, and automating this process using GitHub Actions.

When drift is detected, notifications are sent to Slack to ensure visibility and quick response.

---

## Objective

The goal of this project is to:

- Provision infrastructure using Terraform
- Store Terraform state remotely using AWS S3
- Detect infrastructure drift automatically using CI/CD
- Send notifications using Slack
- Understand real-world DevOps workflows and debugging

---

## What is Infrastructure Drift

Infrastructure drift occurs when the actual state of resources in the cloud differs from the configuration defined in Terraform.

Example:

- Defined in Terraform: instance_type = "t2.micro"
- Changed manually in AWS: instance_type = "t2.nano"

This mismatch is called drift.

---

## Architecture

GitHub Repository  
→ GitHub Actions Workflow  
→ Terraform Plan Execution  
→ Drift Detection Logic  
→ Slack Notification  
→ AWS Infrastructure (EC2)

---

## Technologies Used

- Terraform
- AWS EC2
- AWS S3 (Remote Backend)
- GitHub Actions
- Slack Webhook
- Bash scripting

---

## Project Structure

Day-8/
├── main.tf  
├── variables.tf  
├── backend.tf  
├── .github/workflows/terraform.yml  

---

## Terraform Configuration

### EC2 Instance

The infrastructure includes an EC2 instance created using Terraform.

The instance type is controlled through a variable to make it flexible.

---

### Variables

A variable is used to define the instance type:

- Default value: t2.micro
- Allows easy modification and drift testing

---

### Remote Backend (S3)

Terraform state is stored remotely in an S3 bucket to ensure:

- State consistency
- Team collaboration
- CI/CD compatibility

---

## CI/CD Workflow (GitHub Actions)

The GitHub Actions workflow performs the following steps:

1. Checkout repository code
2. Setup Terraform
3. Configure AWS credentials
4. Initialize Terraform backend
5. Run Terraform plan
6. Detect drift using exit codes
7. Send Slack notification

---

## Drift Detection Logic

Terraform uses exit codes to indicate changes:

- Exit code 0 → No changes (no drift)
- Exit code 2 → Changes detected (drift present)

This logic is used in the workflow to determine whether drift exists.

---

## Slack Integration

Slack webhook is used to send notifications:

- If drift is detected → alert message is sent
- If no drift → success message is sent

This simulates real-world alerting systems used in DevOps environments.

---

## Testing Process

The following steps were used to test drift detection:

1. Created EC2 instance using Terraform with instance type "t2.micro"
2. Manually changed instance type in AWS console to "t2.nano"
3. Ran Terraform plan locally to verify drift detection
4. Triggered GitHub Actions workflow

---

## Challenges Faced

During implementation, several real-world issues were encountered:

- YAML syntax errors in GitHub Actions workflow
- Backend configuration mismatch between local and CI
- Drift detection inconsistencies due to state synchronization
- JSON formatting issues in Slack webhook
- Understanding Terraform exit codes and behavior

---

## Key Learnings

- Importance of remote state management in Terraform
- How Terraform plan detects infrastructure changes
- How CI/CD pipelines can be used for infrastructure validation
- Debugging real DevOps workflows
- Integrating external tools like Slack for notifications

---

## Limitations

- Drift detection depends on correct backend configuration
- CI pipeline must use the same state as local environment
- Slack notifications are basic and can be enhanced

---

## Future Improvements

- Add Terraform format and validation steps
- Implement approval workflow before apply
- Integrate AWS Config for continuous monitoring
- Use Terraform Cloud or remote execution
- Improve Slack messages with structured formatting
- Add logging and monitoring

---

## Conclusion

This project demonstrates how infrastructure can be managed and monitored using Terraform and CI/CD pipelines. It reflects real-world DevOps practices such as automation, monitoring, and alerting.

Even with challenges, the implementation provided valuable experience in debugging and understanding how infrastructure behaves in dynamic environments.

---
