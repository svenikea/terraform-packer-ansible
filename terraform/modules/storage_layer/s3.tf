resource "aws_s3_bucket" "app_bucket" {
    count                   = length(var.bucket_list)
    bucket                  = "${var.project}-${var.bucket_list[count.index]}-${var.environment}-${local.timestamp_filtered}"
    force_destroy           = true
    tags = {
        Name                = "${var.project}-${var.bucket_list[count.index]}-${var.environment}-${local.timestamp_filtered}"
        Env                 = var.environment
    }
}

resource "aws_s3_bucket_public_access_block" "block_s3_public_access" {
    count                   = length(var.bucket_list)
    bucket                  = aws_s3_bucket.app_bucket.*.id[count.index]
    block_public_acls       = true
    block_public_policy     = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "web_static_acl" {
    count                   = length(var.bucket_list)
    bucket                  = aws_s3_bucket.app_bucket.*.id[count.index]
    acl                     = "private"
}
