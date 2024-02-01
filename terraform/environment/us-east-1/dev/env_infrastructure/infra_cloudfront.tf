module "acm_cdn"{
    source                                  = "../modules/acm"
    project_domain                          = var.project_domain
    project_sub_domain                      = "cdn.${var.env}"
    validation_method                       = "DNS"
    route53_enable                          = var.route53_enable
    new_acm                                 = var.new_acm  
}

module "cdn" {
    source                                  = "../modules/cloudfront"
    
    env                                     = "${var.env}"
    acm_arn                                 = module.acm_cdn.acm_arn
    target_origin_id                        = "${local.cdn_loadbalance_id}"
    price_class                             = "PriceClass_All"
    cloudfront_aliases                      = ["cdn.${var.env}.${var.project_domain}"]
    whitelisted_names                       = ["comment_author_*", "comment_author_email_*", "comment_author_url_*", "wordpress_*", "wordpress_logged_in_*", "wordpress_test_cookie", "wp-settings-*"]
    origins                                 = [
        {
            domain_name                     = "stg.${var.project_domain}",
            origin_id                       = "${local.cdn_loadbalance_id}",
            # create_s3_oai = false
            protocol_policy                 = "https-only"
            s3_origin                       = false 
            custom_origin                   = true
        }
        # {
        #     domain_name                     = "${module.s3.web_static_domain_name[1]}",
        #     target_id                       = "${local.cdn_s3_target_id}",
        #     # create_s3_oai = false
        #     protocol_policy                 = "https-only"
        #     s3_origin                       = true
        #     custom_origin                   = false
        # }
         
    ]
    cloudfront_behavior                     = [
        {
            path                            = "/wp-admin/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"],
            cached_methods                  = ["GET", "HEAD", "OPTIONS"],
            query_Strng                     = true,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Origin"],
            target_id                       = "${local.cdn_loadbalance_id}",
            cookies                         = "whitelist",
            whitelist_names                 = ["comment_author_*", "comment_author_email_*", "comment_author_url_*", "wordpress_*", "wordpress_logged_in_*", "wordpress_test_cookie", "wp-settings-*"]

        },
        {
            path                            = "/wp-login.php*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"],
            cached_methods                  = ["GET", "HEAD", "OPTIONS"],
            query_Strng                     = true,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Origin"],
            target_id                       = "${local.cdn_loadbalance_id}",
            cookies                         = "whitelist",
            whitelist_names                 = ["comment_author_*", "comment_author_email_*", "comment_author_url_*", "wordpress_*", "wordpress_logged_in_*", "wordpress_test_cookie", "wp-settings-*"]

        },
        {
            path                            = "/wp-content/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_loadbalance_id}",
            cookies                         = "none",
            whitelist_names                 = null
        },
        {
            path                            = "/wp-includes/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_loadbalance_id}",
            cookies                         = "none",
            whitelist_names                 = null
        },
        {
            path                            = "/about-us/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_loadbalance_id}",
            cookies                         = "none",
            whitelist_names                 = null
        },
        {
            path                            = "/wp-json/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_loadbalance_id}",
            cookies                         = "none",
            whitelist_names                 = null
        },
        {
            path                            = "/?w3tc_minify*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD", "OPTIONS"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Referer", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_loadbalance_id}",
            cookies                         = "none",
            whitelist_names                 = null
        }
    ]
}

locals {
    cdn_loadbalance_id                      = "ALBTargetID-${var.env}"
    cdn_s3_target_id                        = "S3TargetID-${var.env}"
}