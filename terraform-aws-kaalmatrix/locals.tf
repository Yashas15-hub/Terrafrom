locals {
  name_prefix  = lower("kmx-${var.environment}")
  common_tags  = { ManagedBy = "Terraform", CostCenter = "RND" }
  azs          = slice(data.aws_availability_zones.available.names, 0, 2)
  merged_tags  = merge(local.common_tags, { Tier = "app" })
  user_ip_cidr = "${chomp(data.http.ip.response_body)}/32"
  bucket_name  = replace("${local.name_prefix}-assets", "_", "-")
}
