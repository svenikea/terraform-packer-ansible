output "s3_backend" {
    value = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table" {
    value = aws_dynamodb_table.state_locks.name
}