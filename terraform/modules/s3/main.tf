resource "aws_s3_bucket" "s3_bucket" {
    count                   = var.bucket_names != null ? 1 : 0
    bucket                  = "${var.bucket_names}-${var.env}"
    force_destroy           = true
    tags = {
        Terraform           = true
        Name                = "${var.bucket_names}-${var.env}"
        Env                 = var.env
    }
}

resource "aws_s3_object" "object_key" {
    count                   = var.object_key != null ? 1 : null
    bucket                  = aws_s3_bucket.s3_bucket[0].id
    key                     = "${var.object_key}/"
    content_type            = "application/x-directory"
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle" {
    bucket                  = aws_s3_bucket.s3_bucket[0].bucket
    rule {
        id                  = "${var.bucket_names}-${var.env}-lifecycle"
        status              = "Enabled"
        transition {
            days            = 30
            storage_class   = "STANDARD_IA"
        }   
        transition {
            days            = 60
            storage_class   = "GLACIER"
        }           
    }
    depends_on              = [aws_s3_bucket.s3_bucket]
}

resource "aws_s3_bucket_public_access_block" "block_s3_public_access" {
    bucket                  = aws_s3_bucket.s3_bucket[0].id
    block_public_acls       = true
    block_public_policy     = true
    restrict_public_buckets = true
    ignore_public_acls      = true
    depends_on              = [aws_s3_bucket.s3_bucket]
    # block_public_acls       = var.bucket_names[count.index] == var.bucket_names[0] ? true : false
    # block_public_policy     = var.bucket_names[count.index] == var.bucket_names[0] ? true : false
    # restrict_public_buckets = var.bucket_names[count.index] == var.bucket_names[0] ? true : false
    # ignore_public_acls      = var.bucket_names[count.index] == var.bucket_names[0] ? true : false
}

resource "aws_s3_bucket_acl" "web_static_acl" {
    bucket                  = aws_s3_bucket.s3_bucket[0].id
    depends_on              = [aws_s3_bucket.s3_bucket]
    acl                     = "private"
    # acl                     = var.bucket_names[count.index] == var.bucket_names[0] ? "private" : "public-read"
}

resource "aws_s3_bucket_versioning" "buckets_versioning" {
    bucket                  = aws_s3_bucket.s3_bucket[0].id
    versioning_configuration {
        status              = var.s3_versioning
    }
    depends_on              = [aws_s3_bucket.s3_bucket]
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket                  = aws_s3_bucket.s3_bucket[0].id
    policy                  = var.bucket_policy
    depends_on              = [aws_s3_bucket.s3_bucket]
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
#     count                   = var.bucket_names != null ? length(var.bucket_names) : 0
#     bucket                  = aws_s3_bucket.s3_bucket.*.bucket[count.index]
#     rule {
#         apply_server_side_encryption_by_default {
#         sse_algorithm     = "AES256"
#         }
#     }
# }       

# resource "aws_s3_bucket_policy" "static_bucket_policy" {
#     bucket                  = aws_s3_bucket.s3_bucket.*.bucket[1]
#     policy                  = var.bucket_policy
# }
