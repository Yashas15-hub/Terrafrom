variable "subnet_ids" { type = list(string) }
variable "sg_id" { type = string }
variable "ami_id" { type = string }
variable "instance_names" { type = list(string) }
variable "key_name" {
  type    = string
  default = null
}
variable "user_data" { type = string }
variable "tags" { type = map(string) }
