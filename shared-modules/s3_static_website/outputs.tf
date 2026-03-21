output "bucket_id" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "website_endpoint" {
  description = "S3 website endpoint (http://...)"
  value       = var.enable_website_hosting ? local.website_endpoint : null
}
