resource "random_id" "this" {
  byte_length = 2
}

resource "aws_s3_bucket" "demo" {
  count  = var.enable_demo_bucket ? 1 : 0
  bucket = "${local.bucket_name}-${random_id.this.hex}"
  tags   = local.merged_tags
}

module "vpc" {
  source              = "./modules/vpc"
  name_prefix         = local.name_prefix
  azs                 = local.azs
  allowed_cidrs_extra = var.allowed_cidrs
  my_ip_cidr          = local.user_ip_cidr
  tags                = local.merged_tags
}

module "ec2" {
  source         = "./modules/ec2"
  subnet_ids     = module.vpc.public_subnet_ids
  sg_id          = module.vpc.sg_id
  ami_id         = data.aws_ami.ubuntu_minimal.id
  instance_names = var.instance_names
  key_name       = var.key_pair_name
  user_data      = templatefile("${path.module}/user_data.sh.tftpl", { env = var.environment })
  tags           = local.merged_tags
  depends_on     = [module.vpc]
}
