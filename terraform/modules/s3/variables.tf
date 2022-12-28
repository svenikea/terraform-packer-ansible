variable "project" {}
variable "env" {}
variable "bucket_names" {}
variable "s3_versioning" { default = "Disabled" }
variable "bucket_policy" {}
variable "object_key" { default = null }
