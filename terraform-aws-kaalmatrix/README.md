# KaalMatrix Terraform AWS Mini-Stack

Demonstrates key Terraform Associate (003) concepts with a Free-Tier stack: S3/DynamoDB backend, VPC, subnets, SG, EC2, conditional S3, modules, dynamic blocks, functions, templatefile, validations, workspaces, and outputs.

## Bootstrap backend
```
cd 00-bootstrap
terraform init
terraform apply -auto-approve
```
Copy outputs to `backend.hcl`.

## Initialize & apply
```
cd ..
terraform init -backend-config=backend.hcl
terraform workspace new dev || true
terraform workspace select dev
terraform plan  -var-file=envs/dev.tfvars
terraform apply -var-file=envs/dev.tfvars -auto-approve
terraform output
```
