variable "name_prefix" { type = string }
variable "azs" { type = list(string) }
variable "allowed_cidrs_extra" { type = list(string) }
variable "my_ip_cidr" { type = string }
variable "tags" { type = map(string) }
