variable "top_level_domain" {}

variable "prod_account_id" {
  sensitive = true
}

variable "nonprod_account_id" {
  sensitive = true
}

variable "assume_role" {
  sensitive = true
}
