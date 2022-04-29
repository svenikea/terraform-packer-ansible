variable "environment" {}
variable "project" {}
variable "bucket_arns" {}
data "aws_caller_identity" "current" {}
variable "iam_users" {}
variable "region" {}
variable "account_id" {}