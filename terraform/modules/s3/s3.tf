resource "aws_s3_bucket" "s3_buckets" {
    count                   = var.bucket_names != null ? length(var.bucket_names) : 0
    bucket                  = "${var.project}-${var.bucket_names[count.index]}-${var.env}-${local.timestamp_filtered}"
    force_destroy           = true
    tags = {
        Name                = "${var.project}-${var.bucket_names[count.index]}-${var.env}-${local.timestamp_filtered}"
        Env                 = var.env
    }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle" {
    count                   = var.bucket_names != null ? length(var.bucket_names) : 0
    bucket                  = aws_s3_bucket.s3_buckets[count.index].bucket
    rule {
        id                  = "${var.project}-${var.bucket_names[count.index]}-${var.env}-lifecycle"
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
    count                   = var.bucket_names != null ? length(var.bucket_names) : 0
    bucket                  = aws_s3_bucket.s3_buckets.*.id[count.index]
    block_public_acls       = true
    block_public_policy     = true
    restrict_public_buckets = true
    ignore_public_acls      = true
    # block_public_acls       = var.bucket_names[count.index] == var.bucket_names[0] ? true : false
    # block_public_policy     = var.bucket_names[count.index] == var.bucket_names[0] ? true : false
    # restrict_public_buckets = var.bucket_names[count.index] == var.bucket_names[0] ? true : false
    # ignore_public_acls      = var.bucket_names[count.index] == var.bucket_names[0] ? true : false
}

resource "aws_s3_bucket_acl" "web_static_acl" {
    count                   = var.bucket_names != null ? length(var.bucket_names) : 0
    bucket                  = aws_s3_bucket.s3_buckets.*.id[count.index]
    acl                     = "private"
    # acl                     = var.bucket_names[count.index] == var.bucket_names[0] ? "private" : "public-read"
}

resource "aws_s3_bucket_versioning" "buckets_versioning" {
    count                   = var.bucket_names != null ? length(var.bucket_names) : 0
    bucket                  = aws_s3_bucket.s3_buckets.*.id[count.index]
    versioning_configuration {
        status              = var.s3_versioning
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
    count                   = var.bucket_names != null ? length(var.bucket_names) : 0
    bucket                  = aws_s3_bucket.s3_buckets.*.bucket[count.index]
    rule {
        apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
        }
    }
}       

resource "aws_s3_bucket_policy" "static_bucket_policy" {
    bucket                  = aws_s3_bucket.s3_buckets.*.bucket[1]
    policy                  = var.bucket_policy
}
