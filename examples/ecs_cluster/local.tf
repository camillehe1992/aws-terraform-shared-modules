locals {
  tags = {
    Example = "ecs_cluster"
  }
  # ECS Cluster
  fargate_only_cluster_name        = "fargate-only-cluster"
  fargate_managed_ec2_cluster_name = "fargate-managed-ec2-cluster"
  custom_ec2_cluster_name          = "fargate-custom-ec2-cluster"


  image = {
    use = "x86_64"
    x86_64 = {
      image_id       = "ami-07e9b90435807cab4"
      image_name     = "al2023-ami-ecs-hvm-2023.0.20260223-kernel-6.1-x86_64"
      instance_types = ["t3.medium", "c5.large", "c5.xlarge"]
    }
    arm64 = {
      image_id       = "ami-00515ceb0071550bd"
      image_name     = "al2023-ami-ecs-hvm-2023.0.20260114-kernel-6.1-arm64"
      instance_types = ["c6g.large", "c6g.xlarge", "c6g.2xlarge"]
    }
  }
  # Managed Instances Provider
  managed_instances_provider = {
    storage_size_gib     = 30
    min_meory_mib        = 1024
    max_meory_mib        = 2048
    min_vcpu_count       = 1
    max_vcpu_count       = 4
    instance_generations = ["current"]
    cpu_manufacturers    = ["amazon-web-services"]
  }

  # Network
  network = {
    vpc_id             = data.aws_vpc.default.id
    public_subnet_ids  = data.aws_subnets.public.ids
    private_subnet_ids = data.aws_subnets.private.ids
    security_group_ids = [data.aws_security_group.default.id]
  }
}
