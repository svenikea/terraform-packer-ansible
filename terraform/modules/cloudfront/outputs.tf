output "cloudfront_origin_identity_arn" {
    value = aws_cloudfront_origin_access_identity.cloudfront_oai.iam_arn
}

output "main_site_dns" {
    value = aws_cloudfront_distribution.main_site.domain_name
}