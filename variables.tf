variable "site_name" {
  description = "Name of bucket to be created in S3. Must be globally unique."
  type        = string
}
variable "cf_default_ttl" {
  description = "CloudFront default TTL for cachine"
  type        = string
  default     = "86400"
}
variable "cf_min_ttl" {
  description = "CloudFront minimum TTL for caching"
  type        = string
  default     = "0"
}
variable "cf_max_ttl" {
  description = "CloudFront maximum TTL for caching"
  type        = string
  default     = "31536000"
}
variable "cf_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_All"
}
variable "allowed_methods" {
  description = "Allowed methods for accessing the CloudFront Distribution"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}
variable "cached_methods" {
  description = "Cache  methods for accessing the CloudFront Distribution"
  type        = list(string)
  default     = ["GET", "HEAD"]
}
variable "cors_allowed_headers" {
  description = "List of headers allowed in CORS"
  type        = list(string)
  default     = []
}
variable "cors_allowed_methods" {
  description = "List of methods allowed in CORS"
  type        = list(string)
  default     = ["GET"]
}
variable "cors_allowed_origins" {
  description = "List of origins allowed to make CORS requests"
  type        = list(string)
  default     = ["https://s3.amazonaws.com"]
}
variable "cors_expose_headers" {
  description = "List of headers to expose in CORS response"
  type        = list(string)
  default     = []
}
variable "cors_max_age_seconds" {
  description = "Specifies time in seconds that browser can cache the response for a preflight request"
  type        = string
  default     = 3000
}
variable "custom_error_response" {
  description = "Optionally a list of custom error response configurations for CloudFront distribution"
  type = set(object({
    error_code         = number
    response_code      = number
    response_page_path = string
  }))
  default = null
}
variable "default_root_object" {
  description = "CloudFront distribution default_root_object"
  type        = string
  default     = "index.html"
}
variable "error_document" {
  description = "Error page document in S3 bucket"
  type        = string
  default     = "404.html"
}
variable "index_document" {
  description = "Index page document in S3 bucket"
  type        = string
  default     = "index.html"
}
variable "origin_path" {
  description = "Path in S3 bucket for hosted files, with leading slash"
  type        = string
  default     = ""
}
variable "routing_rules" {
  description = "A json array containing routing rules describing redirect behavior and when redirects are applied"
  type        = map(string)
  default = {
    "/" = "index.html"
  }
}
variable "minimum_tls_version" {
  type        = string
  default     = "TLSv1.2_2021"
  description = "Minimum support TLS version"
}
variable "s3_origin_id" {
  description = "Origin ID used in CloudFront"
  type        = string
  default     = "s3-origin"
}
variable "viewer_protocol_policy" {
  description = "One of allow-all, https-only, or redirect-to-https"
  type        = string
  default     = "redirect-to-https"
}
variable "logging_bucket" {
  type        = string
  description = "Target Bucket name for logging"
}

variable "cloudfront_certificate_arn" {
  description = "ARN of the ACM certificate to use for cloudfront. Must be issued in us-east-1"
  type        = string
}
variable "cloudfront_aliases" {
  description = "List of hostnames to serve site on. E.g. with and without www"
  type        = list(string)
}
variable "cloudfront_allowed_methods" {
  description = "Allowed methods for accessing the CloudFront Distribution"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
}
variable "cloudfront_cached_methods" {
  description = "Cache  methods for accessing the CloudFront Distribution"
  type        = list(string)
  default     = ["GET", "HEAD"]
}
variable "cloudfront_minimum_tls_version" {
  description = "Minimum allowed TLS version"
  type        = string
  default     = "TLSv1.2_2021"
}
variable "cloudfront_origin_id" {
  description = "Origin ID used in CloudFront"
  type        = string
  default     = "alb"
}
variable "cloudfront_viewer_protocol_policy" {
  description = "One of allow-all, https-only, or redirect-to-https"
  type        = string
  default     = "redirect-to-https"
}
variable "cloudfront_default_ttl" {
  description = "CloudFront default TTL for cachine"
  type        = string
  default     = "1"
}
variable "cloudfront_min_ttl" {
  description = "CloudFront minimum TTL for caching"
  type        = string
  default     = "0"
}
variable "cloudfront_max_ttl" {
  description = "CloudFront maximum TTL for caching"
  type        = string
  default     = "10"
}
variable "cloudfront_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_All"
}
variable "context" {
  type = object({
    organization = string
    environment  = string
    account      = string
    product      = string
    tags         = map(string)
  })
  description = "Default environmental context"
}
