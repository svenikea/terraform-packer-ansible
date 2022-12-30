module "acm" {
    source              = "../modules/acm"
    project_domain      = var.env == "stg" ? "${var.env}.${var.project_domain}" : var.env == "prod" ? "${var.project_domain}" : "${var.project_domain}"
    validation_method   = "DNS"
    route53_enable      = var.route53_enable
    new_acm             = var.new_acm  
}