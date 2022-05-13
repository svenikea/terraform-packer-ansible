resource "aws_s3_bucket" "s3_buckets" {
    count                   = length(var.bucket_list)
    bucket                  = "${var.project}-${var.bucket_list[count.index]}-${var.environment}-${local.timestamp_filtered}"
    force_destroy           = true
    tags = {
        Name                = "${var.project}-${var.bucket_list[count.index]}-${var.environment}-${local.timestamp_filtered}"
        Env                 = var.environment
    }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle" {
    count                   = length(var.bucket_list)
    bucket                  = aws_s3_bucket.s3_buckets[count.index].bucket
    rule {
        id                  = "${var.project}-${var.bucket_list[count.index]}-${var.environment}-lifecycle"
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
}

resource "aws_s3_bucket_public_access_block" "block_s3_public_access" {
    count                   = length(var.bucket_list)
    bucket                  = aws_s3_bucket.s3_buckets.*.id[count.index]
    block_public_acls       = var.bucket_list[count.index] == var.bucket_list[0] ? true : false
    block_public_policy     = var.bucket_list[count.index] == var.bucket_list[0] ? true : false
    restrict_public_buckets = var.bucket_list[count.index] == var.bucket_list[0] ? true : false
}

resource "aws_s3_bucket_acl" "web_static_acl" {
    count                   = length(var.bucket_list)
    bucket                  = aws_s3_bucket.s3_buckets.*.id[count.index]
    acl                     = var.bucket_list[count.index] == var.bucket_list[0] ? "private" : "public-read"
}

resource "aws_s3_bucket_versioning" "buckets_versioning" {
    count                   = length(var.bucket_list)
    bucket                  = aws_s3_bucket.s3_buckets.*.id[count.index]
    versioning_configuration {
        status              = var.s3_versioning
    }
}
