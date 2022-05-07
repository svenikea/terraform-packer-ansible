variable "environment" {}
variable "project" {}
variable "vpc_id" {}
variable "region" {}
variable "bucket_list" {}
variable "s3_versioning" {}

locals {
  timestamp = "${timestamp()}"
  timestamp_filtered = "${replace("${local.timestamp}", "/[-| |T|Z|:]/", "")}"
}