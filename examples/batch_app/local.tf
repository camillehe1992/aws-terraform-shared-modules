locals {
  aws_partition  = data.aws_partition.this.partition
  aws_region     = data.aws_region.current.id
  aws_account_id = data.aws_caller_identity.this.account_id

  network = {
    vpc_id                 = data.aws_vpc.default.id
    public_subnet_ids      = data.aws_subnets.public.ids
    private_subnet_ids     = data.aws_subnets.private.ids
    private_route_table_id = data.aws_route_table.private.id
    security_group_ids     = [data.aws_security_group.default.id]
  }

  priority                        = 10
  spot_iam_fleet_role_arn         = "arn:${local.aws_partition}:iam::${local.aws_account_id}:role/aws-service-role/spot.amazonaws.com/AWSServiceRoleForEC2Spot"
  batch_service_role_arn          = "arn:${local.aws_partition}:iam::${local.aws_account_id}:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch"
  batch_instance_role_profile_arn = replace(module.batch_instance_role.role_arn, ":role/", ":instance-profile/")

  tags = {
    "Example" = "batch"
  }
}
