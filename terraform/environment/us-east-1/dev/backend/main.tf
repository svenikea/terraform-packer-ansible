resource "aws_s3_bucket" "terraform_state" {
    bucket                  = var.backend_s3

    lifecycle {
        prevent_destroy     = true
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encrypt" {
    bucket                  = aws_s3_bucket.terraform_state.bucket
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm   = "AES256"
        }
    }
}

resource "aws_dynamodb_table" "state_locks" {
    name                    = var.backend_dynamodb
    billing_mode            = "PAY_PER_REQUEST"
    hash_key                = "LockID"
    attribute {
        name                = "LockID"
        type                = "S"
    }   
}