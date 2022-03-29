resource "aws_s3_bucket" "app_bucket" {
    count               = length(var.bucket_list)
    bucket              = "${var.project}-${var.bucket_list[count.index]}-${var.environment}"
    force_destroy       = true
    tags = {
        Name            = "${var.project}-${var.bucket_list[count.index]}-${var.environment}"
        Env             = var.environment
    }
}

resource "aws_s3_bucket_acl" "web_static_acl" {
    count               = length(var.bucket_list)
    bucket              = aws_s3_bucket.app_bucket.*.id[count.index]
    acl                 = "private"
}
