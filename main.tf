module "this_label" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = ["hosting", var.site_name]
}
module "bucket" {
  source                = "git::github.com/xoap-io/terraform-aws-storage-s3.git?ref=v0.1.0"
  context               = var.context
  name                  = var.site_name
  website_enabled       = true
  error_document        = var.error_document
  index_document        = var.index_document
  routing_rules         = var.routing_rules
  cors_allowed_methods  = var.cors_allowed_methods
  cors_allowed_origins  = var.cors_allowed_origins
  cors_allowed_header   = var.cors_allowed_headers
  cors_exposed_header   = var.cors_expose_headers
  kms_arn               = ""
  logging_bucket        = ""
  disable_public_access = false
}
resource "aws_cloudfront_cache_policy" "this" {
  name        = module.this_label.id
  min_ttl     = var.cf_min_ttl
  default_ttl = var.cf_default_ttl
  max_ttl     = var.cf_max_ttl
  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true
    cookies_config {
      cookie_behavior = "all"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }

  }
}
resource "aws_cloudfront_origin_request_policy" "this" {
  name = module.this_label.id
  cookies_config {
    cookie_behavior = "all"
  }
  headers_config {
    header_behavior = "none"
  }
  query_strings_config {
    query_string_behavior = "all"
  }
}
#tfsec:ignore:AWS045
resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = module.bucket.website_endpoint
    origin_id   = var.s3_origin_id
    origin_path = var.origin_path
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  dynamic "custom_error_response" {
    for_each = var.custom_error_response != null ? var.custom_error_response : []
    content {
      error_code         = custom_error_response.value.error_code
      response_code      = custom_error_response.value.response_code
      response_page_path = custom_error_response.value.response_page_path
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object
  aliases             = var.cloudfront_aliases
  default_cache_behavior {
    allowed_methods          = var.allowed_methods
    cached_methods           = var.cached_methods
    target_origin_id         = var.s3_origin_id
    compress                 = true
    cache_policy_id          = aws_cloudfront_cache_policy.this.id
    origin_request_policy_id = aws_cloudfront_origin_request_policy.this.id
    viewer_protocol_policy   = var.viewer_protocol_policy
    min_ttl                  = var.cf_min_ttl
    max_ttl                  = var.cf_max_ttl
    default_ttl              = var.cf_default_ttl
  }
  price_class = var.cf_price_class
  viewer_certificate {
    acm_certificate_arn      = var.cloudfront_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = var.minimum_tls_version
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  #  logging_config {
  #    bucket = data.aws_s3_bucket.logging.bucket_domain_name
  #    prefix = "${module.this_label.id}/"
  #  }
}
