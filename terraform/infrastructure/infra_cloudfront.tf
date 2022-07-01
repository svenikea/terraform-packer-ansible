module "s3_cloudfront" {
    source                                  = "../modules/cloudfront"

    env                                     = var.env

    s3_domain_name                          = module.s3.web_static_domain_name[1]
    s3_origin_id                            = module.s3.web_static_domain_name[1]
}

module "main_site_cloudfront" {
    source                                  = "../modules/cloudfront_main_site"

    env                                     = var.env

    main_site_dns                           = module.alb.alb_endpoint
    main_site_id                            = module.alb.alb_endpoint
}

module "custom_managed_cache_policy" {
    source                                  = "../modules/cloudfront_cache_policy"
    
    cache_policy_name                       = "Custom-Managed-Cache-Policy"
    cookie_behavior                         = "all"
    header_behavior                         = "whitelist"
    query_string_behavior                   = "all"
    header_items                            = ["Origin", "Referer", "Host"]
}

module "custom_header_passed" {
    source                                  = "../modules/cloudfront_origin_request_policy"

    origin_request_policy_name              = "Custom-headers-passed"
    cookie_behavior                         = "whitelist"
    query_string_behavior                   = "all"
    header_behavior                         = "whitelist"
    cookie_items                            = [
        "cookiescomment_author_*", 
        "comment_author_email_*",
        "wordpress_test_cookie",
        "comment_author_url_*",
        "wordpress_*",
        "wordpress_logged_in_*",
        "PHPSESSID",
        "wordpress_sec_*",
        "wp-settings-*"
    ]
    header_items                            = [
        "Origin",
        "Host",
        "Referer",
        "CloudFront-Is-Tablet-Viewer",
        "CloudFront-Is-Mobile-Viewer",
        "CloudFront-Is-Desktop-Viewer"
    ]
}

module "custom_header_passed_nocache" {
    source                                  = "../modules/cloudfront_origin_request_policy"

    origin_request_policy_name              = "Custom-Header-Passed-NoCache"
    cookie_behavior                         = "all"
    query_string_behavior                   = "all"
    header_behavior                         = "allViewer"
}

module "general_cloudfront" {
    source                                  = "../modules/cloudfront_general"
    
    env                                     = "stg"
    target_id                               = local.cdn_alb_target_id 
    acm_arm                                 = module.acm.acm_arm
    price_class                             = "PriceClass_All"
    cloudfront_aliases                      = ["cdn.${var.route53_domain}"]
    origins                                 = [
        {
            domain_name                     = "cdn.${var.route53_domain}",
            target_id                       = "${local.cdn_alb_target_id}",
            # create_s3_oai = false
            protocol_policy                 = "http-only"
            s3_origin                       = true
            custom_origin                   = false
        },
        {
            domain_name                     = "s3.${var.route53_domain}",
            target_id                       = "${local.cdn_s3_target_id}",
            # create_s3_oai = false
            protocol_policy                 = "http-only"
            s3_origin                       = false
            custom_origin                   = true
        }
         
    ]
    cloudfront_behavior                     = [
        {
            path                            = "/wp-admin/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"],
            cached_methods                  = ["GET", "HEAD", "OPTIONS"],
            query_Strng                     = true,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Origin", "Host", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_alb_target_id}",
            cookies                         = "all"
        },
        {
            path                            = "/wp-login.php*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"],
            cached_methods                  = ["GET", "HEAD", "OPTIONS"],
            query_Strng                     = true,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["*"],
            target_id                       = "${local.cdn_alb_target_id}",
            cookies                         = "all"
        },
        {
            path                            = "/wp-content/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_alb_target_id}",
            cookies                         = "all"
        },
        {
            path                            = "/wp-includes/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Referer", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_alb_target_id}",
            cookies                         = "none"
        },
        {
            path                            = "/about-us/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_alb_target_id}",
            cookies                         = "none"
        },
        {
            path                            = "/wp-json/*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_alb_target_id}",
            cookies                         = "none"
        },
        {
            path                            = "/?w3tc_minify*",
            allowed_methods                 = ["GET", "HEAD", "OPTIONS"],
            cached_methods                  = ["GET", "HEAD", "OPTIONS"],
            query_Strng                     = false,
            viewer_protocol_policy          = "redirect-to-https",
            headers                         = ["Host", "Referer", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"],
            target_id                       = "${local.cdn_alb_target_id}",
            cookies                         = "none"
        }
    ]
}

locals {
    cdn_alb_target_id                       = "AppTargetID"
    cdn_s3_target_id                        = "S3TargetID"
}