🧩 KaalMatrix Terraform AWS Mini-Stack
📁 Project Scaffold

terraform-aws-kaalmatrix/
├── 00-bootstrap/                   # One-time remote-state setup (S3 + DynamoDB)
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── envs/                           # Environment-specific variables (no workspaces needed)
│   ├── dev.tfvars
│   └── prod.tfvars
│
├── modules/
│   ├── vpc/                        # VPC, public subnets, route tables, SG
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── ec2/                        # EC2 instances (count via names), user_data
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── backend.hcl                     # Filled from 00-bootstrap outputs
├── versions.tf                     # Required Terraform + providers + backend type
├── providers.tf                    # AWS + default tags
├── variables.tf                    # Inputs + validation
├── locals.tf                       # Naming, tags, AZs, helpers
├── data.tf                         # AMI lookup, public IP, identity, AZs
├── main.tf                         # Wires modules + conditional S3 demo bucket
├── outputs.tf                      # VPC, subnets, EC2 IPs, optional bucket
├── user_data.sh.tftpl              # Cloud-init bootstrap (Nginx banner)
└── INSTRUCTIONS.md                 # This document


⚙️ Command Order
A) Bootstrap the backend (S3 state + DynamoDB locks)

cd 00-bootstrap
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply -auto-approve

B) Copy outputs to ../backend.hcl

bucket = "<state_bucket from bootstrap>"
key = "core/terraform.tfstate"
region = "us-east-1"
dynamodb_table = "<lock_table from bootstrap>"
encrypt = true

C) Initialize the main stack with the backend

cd ..
terraform init -backend-config=backend.hcl

D) Format & validate

terraform fmt -recursive
terraform validate

E) Plan & apply (DEV)

terraform plan -var-file=envs/dev.tfvars
terraform apply -var-file=envs/dev.tfvars -auto-approve

F) Outputs (example)

terraform output

G) Destroy when finished (use same tfvars you applied with)

terraform destroy -var-file=envs/dev.tfvars

📊 Sample Output

account_id = "666839000177"
demo_bucket_name = "kmx-dev-assets-cabb"
instance_public_ips = [
"18.206.86.160",
"3.89.111.220",
]
public_subnets = [
"subnet-0ef4ae6cc582ecf41",
"subnet-0b22a3c54e589e0f2",
]
vpc_id = "vpc-0d3bb94266ac62219"

🧠 Initialize Git & First Push

From the project root:
git init

Stage and commit:
git add .
git commit -m "chore: initial commit (KaalMatrix Terraform AWS mini-stack)"

Create a new repo on your Git host (GitHub/GitLab/Bitbucket), then add the remote:
git branch -M main
git remote add origin https://github.com/<your-user>/<your-repo>.git
git push -u origin main
