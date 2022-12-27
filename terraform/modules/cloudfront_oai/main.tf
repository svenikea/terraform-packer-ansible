resource "aws_cloudfront_origin_access_identity" "cloudfront_oai" {
    comment = var.oai_comment
}
