module "s3_cloudfront" {
    source                                  = "../modules/cloudfront"

    env                                     = var.env

    domain_name                             = module.s3.web_static_domain_name[1]
    origin_id                               = module.s3.web_static_domain_name[1]
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
