module "acm" {
    source              = "../modules/acm"
    project_domain      = var.env == "stg" ? "${var.env}.${var.project_domain}" : var.env == "prod" ? "${var.project_domain}" : "${var.project_domain}"
    validation_method   = "DNS"
    route53_enable      = var.route53_enable
    new_acm             = var.new_acm  
    ## If using Route 53 then use these resources else comment it
    zone_id             = var.route53_enable != false ? var.zone_id : var.new_acm != false ? var.zone_id : "empty"
}