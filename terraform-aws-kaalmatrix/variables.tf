variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
  validation {
    condition     = can(regex("^us-|^eu-|^ap-", var.region))
    error_message = "Use a standard AWS region code like us-east-1."
  }
}

variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be 'dev' or 'prod'."
  }
}

variable "owner" {
  type    = string
  default = "yashas"
}

variable "allowed_cidrs" {
  type        = list(string)
  default     = []
  description = "Additional ingress CIDRs to allow (on top of your public IP)."
}

variable "instance_names" {
  type        = list(string)
  default     = ["bastion"]
  description = "Instances to create (count demo)."
}

variable "enable_demo_bucket" {
  type        = bool
  default     = true
  description = "Conditional resource demo."
}

variable "key_pair_name" {
  type        = string
  default     = null
  description = "If provided, attach an existing key pair to instances."
}
