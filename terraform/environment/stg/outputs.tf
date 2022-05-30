output "aws_account_id" {
  value = <<VALUE
  Current AWS:
    AWS Account ID: "${data.aws_caller_identity.current.account_id}"
    AWS Account ARN: "${data.aws_caller_identity.current.arn}"
  VALUE
}
