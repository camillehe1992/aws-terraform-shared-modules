output "amplify_app" {
  description = "ARN of the Amplify app"
  value = { for key, value in aws_amplify_app.this : key => {
    arn               = value.arn
    default_domain    = value.default_domain
    production_branch = value.production_branch
  } }
}
