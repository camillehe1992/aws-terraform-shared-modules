module "template" {
  source = "../../shared-modules/_template"

  name = "World"
}

output "greeting" {
  value = module.template.greeting
}
