variable "top_level_domain" {}
variable "aws_region" {}
variable "account_id" {
  sensitive = true
}

variable "assume_role" {
  sensitive = true
}
