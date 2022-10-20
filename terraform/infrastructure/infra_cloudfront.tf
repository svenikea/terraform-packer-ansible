module "custom_header_passed_nocache" {
    source                                  = "../modules/cloudfront_origin_request_policy"

    origin_request_policy_name              = "Custom-Header-Passed-NoCache"
    cookie_behavior                         = "all"
    query_string_behavior                   = "all"
    header_behavior                         = "allViewer"
}

module "cloudfront" {
    source                                  = "../modules/cloudfront_general"
    
    env                                     = "${var.env}"
    target_id                               = local.cdn_alb_target_id 
    acm_arn                                 = module.main_site_acm.acm_arn
    price_class                             = "PriceClass_All"
    cloudfront_aliases                      = ["cdn.${var.route53_zone}"]
    origins                                 = [
        {
            domain_name                     = "${var.route53_zone}",
            target_id                       = "${local.cdn_alb_target_id}",
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
            target_id                       = "${local.cdn_alb_target_id}",
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
            target_id                       = "${local.cdn_alb_target_id}",
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
            target_id                       = "${local.cdn_alb_target_id}",
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
            target_id                       = "${local.cdn_alb_target_id}",
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
            target_id                       = "${local.cdn_alb_target_id}",
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
            target_id                       = "${local.cdn_alb_target_id}",
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
            target_id                       = "${local.cdn_alb_target_id}",
            cookies                         = "none",
            whitelist_names                 = null
        }
    ]
}

locals {
    cdn_alb_target_id                       = "ALBTargetID"
    cdn_s3_target_id                        = "S3TargetID"
}
