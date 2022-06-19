resource "aws_cloudfront_distribution" "cloudfront_to_s3" {
    enabled                             = true

    origin {
        domain_name                     = var.s3_domain_name
        origin_id                       = var.s3_origin_id
        s3_origin_config {
            origin_access_identity      = aws_cloudfront_origin_access_identity.cloudfront_oai.cloudfront_access_identity_path
        }
    }

    default_cache_behavior {
        allowed_methods                 = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods                  = ["GET", "HEAD", "OPTIONS"]
        target_origin_id                = var.s3_origin_id
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

resource "aws_cloudfront_origin_access_identity" "cloudfront_oai" {
    comment                             = "S3 OAI"
}

resource "aws_cloudfront_distribution" "main_site" {
    enabled                             = true  
    origin {
        domain_name                     = var.main_site_dns
        origin_id                       = var.main_site_id
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
