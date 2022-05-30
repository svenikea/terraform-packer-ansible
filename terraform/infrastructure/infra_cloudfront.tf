module "cloudfront" {
    source                                  = "../modules/cloudfront"

    env                                     = var.env

    s3_bucket_dns_name                      = module.s3.web_static_domain_name[1]
}
