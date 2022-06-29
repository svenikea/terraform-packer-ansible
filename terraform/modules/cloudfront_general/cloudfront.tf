resource "aws_cloudfront_distribution" "cdn" {
    aliases                 = var.cloudfront_aliases
    enabled                 = true
    is_ipv6_enabled         = true
    price_class             = var.price_class
    retain_on_delete        = false
    wait_for_deployment     = true

    dynamic "origin" {
        for_each            = var.domain_name
        content {
            domain_name     = origin.value.domain_name
            origin_id       = origin.value.domain_name
            dynamic "s3_origin_config" {
                for_each    = origin.value.create_s3_oai != false ? origin.value.create_s3_oai : 0
                content {
                    origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_oai.cloudfront_access_identity_path
                }
            }
            custom_origin_config {
                http_port              = 80
                https_port             = 443
                origin_protocol_policy = origin.value.protocol_policy
                origin_ssl_protocols   = ["TLSv1.2"]
            }
        } 
    }
    default_cache_behavior {
        allowed_methods                 = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods                  = ["GET", "HEAD", "OPTIONS"]
        target_origin_id                = "cdn"
        viewer_protocol_policy          = "redirect-to-https"

        forwarded_values {
            query_string                    = false
            cookies {
                forward                     = "none"
            } 
        }
    }
    dynamic "ordered_cache_behavior" {
        for_each                        = var.cloudfront_behavior
        content {
            path_pattern     = ordered_cache_behavior.value.path
            allowed_methods  = ordered_cache_behavior.value.allowed_methods
            cached_methods   = ordered_cache_behavior.value.cache_methods
            target_origin_id = "cdn"

            forwarded_values {
            query_string = ordered_cache_behavior.value.query_Strng
            headers      = ordered_cache_behavior.value.headers

                cookies {
                    forward = "none"
                }
            }

            min_ttl                = 0
            default_ttl            = 86400
            max_ttl                = 31536000
            compress               = true
            viewer_protocol_policy = "redirect-to-https"
        }
    }
    restrictions {
        geo_restriction {
            restriction_type            = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate  = true
    }

    tags = {
        Environment                     = var.env
    }  
}

resource "aws_cloudfront_origin_access_identity" "cloudfront_oai" {
    comment                             = "S3 OAI"
}
