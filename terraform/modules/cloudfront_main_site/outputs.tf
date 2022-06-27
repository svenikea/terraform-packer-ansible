output "main_site_dns" {
    value = aws_cloudfront_distribution.main_site.domain_name
}