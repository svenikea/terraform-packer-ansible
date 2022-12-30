module "acm" {
    source              = "../modules/acm"
    project_domain      = var.project_domain
    project_sub_domain  = var.project_sub_domain
    validation_method   = "DNS"
    route53_enable      = var.route53_enable
    new_acm             = var.new_acm  
}