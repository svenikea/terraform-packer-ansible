resource "aws_cloudfront_cache_policy" "cache_policy" {
  name                            = "${var.cache_policy_name}"
  comment                         = "${var.cache_policy_name}"
  default_ttl                     = var.default_ttl
  max_ttl                         = var.max_ttl
  min_ttl                         = var.min_ttl
  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
    cookies_config {
      cookie_behavior             = var.cookie_behavior
      cookies {
        items                     = var.cookie_items
      }
    }
    headers_config {
      header_behavior             = var.header_behavior
      headers {
        items                     = var.header_items
      }
    }
    query_strings_config {
      query_string_behavior       = var.query_string_behavior
      query_strings {
        items                     = var.query_string_items
      }
    }
  }
}
