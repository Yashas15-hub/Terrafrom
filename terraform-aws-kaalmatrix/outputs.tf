output "account_id" { value = data.aws_caller_identity.me.account_id }
output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnets" { value = module.vpc.public_subnet_ids }
output "instance_public_ips" { value = module.ec2.public_ips }
output "demo_bucket_name" {
  value       = try(aws_s3_bucket.demo[0].bucket, null)
  description = "Only when enable_demo_bucket=true"
}
