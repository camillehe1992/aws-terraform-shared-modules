# examples/s3_static_website

Deploy a **public static website** on S3 with:

* S3 Website Hosting (index / error documents)
* Optional CloudFront CDN (HTTPS, HTTP→HTTPS redirect, global edge cache)
* CORS, versioning, configurable public-read, forced bucket destroy
* One-click sample site upload helper

---

## Quick start

1. Pick a **globally unique bucket name** and edit `main.tf`:

   ```hcl
   bucket_name = "my-org-demo-site-2026"
   ```

2. Plan & apply:

   ```bash
   just plan s3_static_website
   just apply s3_static_website
   ```

3. Upload a sample site to S3:

   ```bash
   AWS_PROFILE=app-deployer ./deploy.sh
   ```

4. Browse to the S3 Website Endpoint from the Terraform output `bucket_endpoint`.

5. Destroy the resources:

   ```bash
   just destroy-apply s3_static_website
   ```
