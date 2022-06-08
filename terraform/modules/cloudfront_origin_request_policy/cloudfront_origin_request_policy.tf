resource "aws_cloudfront_origin_request_policy" "origin_request_policy" {
  name    = var.origin_request_policy_name
  comment = var.origin_request_policy_name
  cookies_config {
    cookie_behavior = var.cookie_behavior
    cookies {
      items = var.cookie_items
    }
  }
  headers_config {
    header_behavior = var.header_behavior
    headers {
      items = var.header_items
    }
  }
  query_strings_config {
    query_string_behavior = var.query_string_behavior
    query_strings {
      items = var.query_string_items
    }
  }
}