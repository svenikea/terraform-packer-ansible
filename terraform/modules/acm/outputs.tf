output "acm_domain_validation_options" {
    value = aws_acm_certificate.domain_certificate.domain_validation_options
}

output "acm_arm" {
    value = aws_acm_certificate.domain_certificate.arn
}