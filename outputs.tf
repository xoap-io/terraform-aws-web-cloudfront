output "cloudfront_hostname" {
  value = aws_cloudfront_distribution.this.domain_name
}
output "cloudfront_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}
output "s3" {
  value = module.bucket
}
output "aliases" {
  value = var.cloudfront_aliases
}
output "this" {
  value = [
    for instance in var.cloudfront_aliases :
    {
      alias    = instance
      zone     = aws_cloudfront_distribution.this.hosted_zone_id
      hostname = aws_cloudfront_distribution.this.domain_name
    }
  ]
}
output "cloudfront_id" {
  value = aws_cloudfront_distribution.this.id
}
output "cloudfront_arn" {
  value = aws_cloudfront_distribution.this.arn
}
