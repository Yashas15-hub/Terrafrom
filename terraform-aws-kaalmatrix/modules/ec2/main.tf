resource "aws_instance" "this" {
  count                  = length(var.instance_names)
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  subnet_id              = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name
  user_data              = var.user_data

  lifecycle {
    ignore_changes = [user_data]
  }

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = merge(var.tags, { Name = var.instance_names[count.index] })
}

output "public_ips" { value = [for i in aws_instance.this : i.public_ip] }
output "instance_ids" { value = [for i in aws_instance.this : i.id] }
