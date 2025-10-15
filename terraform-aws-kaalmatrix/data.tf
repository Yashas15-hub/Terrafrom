data "aws_caller_identity" "me" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "http" "ip" {
  url = "https://ipv4.icanhazip.com"
}

data "aws_ami" "ubuntu_minimal" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-focal-20.04-amd64-minimal-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
