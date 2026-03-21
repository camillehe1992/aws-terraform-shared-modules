
locals {
  architecture = "arm64"
  platform     = local.architecture == "arm64" ? "manylinux2014_aarch64" : "manylinux2014_x86_64"
  temp_dir     = ".build"
}
