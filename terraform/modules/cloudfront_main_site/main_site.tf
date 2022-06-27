resource "aws_cloudfront_distribution" "main_site" {
    enabled                             = true  
    origin {
        domain_name                     = var.main_site_dns
        origin_id                       = var.main_site_id
        custom_origin_config {
            http_port              = 80
            https_port             = 443
            origin_protocol_policy = "http-only"
            origin_ssl_protocols   = ["TLSv1.2"]
        }
    }

    default_cache_behavior {
        allowed_methods                 = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods                  = ["GET", "HEAD", "OPTIONS"]
        target_origin_id                = var.main_site_id
        viewer_protocol_policy          = "redirect-to-https"
    
        forwarded_values {
            query_string                = false
            cookies {
                forward                 = "none"
            } 
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