locals {
  common_tags = merge(var.tags, {
    Module = "s3_static_website"
  })
  website_endpoint = "http://${aws_s3_bucket_website_configuration.this[0].website_endpoint}"
  bucket_arn       = aws_s3_bucket.this.arn
}

# ----  bucket  ----
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags          = local.common_tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

#checkov:skip=CKV_AWS_53: "Ensure S3 bucket has block public ACLS enabled"
#checkov:skip=CKV_AWS_54: "Ensure S3 bucket has block public policy enabled"
#checkov:skip=CKV_AWS_55: "Ensure S3 bucket has ignore public ACLS enabled"
#checkov:skip=CKV_AWS_56: "Ensure S3 bucket has restrict public buckets enabled"
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# ----  website hosting  ----
resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.enable_website_hosting ? 1 : 0
  bucket = aws_s3_bucket.this.id

  index_document { suffix = var.index_document }
  error_document { key = var.error_document }
}

# ----  bucket policy  ----
#checkov:skip=CKV_AWS_70: "Ensure S3 bucket does not allow an action with any Principal"
resource "aws_s3_bucket_policy" "this" {
  depends_on = [
    aws_s3_bucket_public_access_block.this,
    aws_s3_bucket_ownership_controls.this,
  ]
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${local.bucket_arn}/*"
      },
    ]
  })
}

# ----  CORS  ----
resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  cors_rule {
    allowed_headers = var.cors_allowed_headers
    allowed_methods = var.cors_allowed_methods
    allowed_origins = var.cors_allowed_origins
    max_age_seconds = 0
  }
}
