output "oai_id" {
    value = aws_cloudfront_origin_access_identity.cloudfront_oai.id
}

output "oai_path" {
    value = aws_cloudfront_origin_access_identity.cloudfront_oai.cloudfront_access_identity_path
}

output "oai_arn" {
    value = aws_cloudfront_origin_access_identity.cloudfront_oai.iam_arn
}