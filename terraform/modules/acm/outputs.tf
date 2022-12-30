# output "acm_domain_validation_options" {
#     value = aws_acm_certificate.domain_certificate.domain_validation_options
# }

output "acm_arn" {
    value = var.new_acm != false ? aws_acm_certificate.domain_certificate[0].arn : null
}

# output "record_name" {
#     value = aws_acm_certificate.domain_certificate.resource_record_name 
# }

# output "record_value" {
#     value = aws_acm_certificate.domain_certificate.resource_record_value
# }
