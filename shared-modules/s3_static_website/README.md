# S3 Static Website Module

Creates S3 buckets configured for static website hosting with CloudFront distribution.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |
## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_cors_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Globally-unique name for the S3 bucket | `string` | n/a | yes |
| <a name="input_cors_allowed_headers"></a> [cors\_allowed\_headers](#input\_cors\_allowed\_headers) | Headers allowed in CORS pre-flight | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_cors_allowed_methods"></a> [cors\_allowed\_methods](#input\_cors\_allowed\_methods) | HTTP verbs allowed via CORS | `list(string)` | <pre>[<br/>  "GET",<br/>  "HEAD"<br/>]</pre> | no |
| <a name="input_cors_allowed_origins"></a> [cors\_allowed\_origins](#input\_cors\_allowed\_origins) | List of origins allowed via CORS (* for all) | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_enable_website_hosting"></a> [enable\_website\_hosting](#input\_enable\_website\_hosting) | Turn on S3 static-website hosting (index + error doc) | `bool` | `true` | no |
| <a name="input_error_document"></a> [error\_document](#input\_error\_document) | File returned for 4xx errors | `string` | `"404.html"` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Delete bucket even when it contains objects | `bool` | `false` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | Default index file | `string` | `"index.html"` | no |
| <a name="input_public_read"></a> [public\_read](#input\_public\_read) | Make bucket contents publicly readable | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to every AWS resource | `map(string)` | `{}` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Keep multiple versions of each object | `bool` | `false` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | S3 bucket ARN |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | S3 bucket name |
| <a name="output_website_endpoint"></a> [website\_endpoint](#output\_website\_endpoint) | S3 website endpoint (http://...) |
<!-- END_TF_DOCS -->
## Examples
See [examples/s3_static_website](../../examples/s3_static_website)
