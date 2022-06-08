resource "aws_acm_certificate" "domain_certificate" {
    domain_name             = var.route53_domain
    validation_method       = "DNS"
}

resource "aws_acm_certificate_validation" "validate_acm" {
  certificate_arn         = aws_acm_certificate.domain_certificate.arn
  validation_record_fqdns = [
      for record in var.route53_record : record.fqdn
    ]
  depends_on              = [var.route53_cname_status]
}
