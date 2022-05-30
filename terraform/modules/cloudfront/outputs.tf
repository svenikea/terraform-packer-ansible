output "cloudfront_origin_identity_arn" {
    value = aws_cloudfront_origin_access_identity.cloudfront_oai.iam_arn
}
