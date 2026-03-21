module "static_site" {
  source = "../../shared-modules/s3_static_website"

  bucket_name = "demo-static-site-2026"
  versioning  = true
  public_read = true

  tags = {
    Environment = "Demo"
    ManagedBy   = "Terraform"
  }
}

output "bucket_endpoint" {
  value = module.static_site.website_endpoint
}
