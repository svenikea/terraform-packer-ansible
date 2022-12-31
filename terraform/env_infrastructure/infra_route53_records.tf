module "main_site_route53_record" {
    source                      = "../modules/route53_records"
    route53_zone_id             = data.aws_route53_zone.current_zone.id
    name                        = var.env == "stg" ? ["${var.env}.${var.project_domain}"] : var.env == "prod" ? ["${var.project_domain}", "www.${var.project_domain}"] : ["${var.project_domain}", "www.${var.project_domain}"]
    record_type                 = "A"
    aliases                     = [
        {
            name                    = module.loadbalance.alb_endpoint
            endpoint_zone_id        = module.loadbalance.alb_zone_id
        } 
    ]
}