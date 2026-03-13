resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

# Ingress

# cidr_ipv4
resource "aws_vpc_security_group_ingress_rule" "allow_cidr_ipv4" {
  for_each = {
    for rule in var.ingress_cidrs :
    "${rule.description}-${rule.cidr_ipv4}" => rule if rule.cidr_ipv4 != null
  }
  security_group_id = aws_security_group.this.id

  description = each.value.description
  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
}

# cidr_ipv6
resource "aws_vpc_security_group_ingress_rule" "allow_cidr_ipv6" {
  for_each = {
    for rule in var.ingress_cidrs :
    "${rule.description}-${rule.cidr_ipv6}" => rule
    if rule.cidr_ipv6 != null
  }
  security_group_id = aws_security_group.this.id

  description = each.value.description
  cidr_ipv6   = each.value.cidr_ipv6
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
}

# prefix_list_id
resource "aws_vpc_security_group_ingress_rule" "allow_prefix_lists" {
  for_each          = var.ingress_prefix_lists
  security_group_id = aws_security_group.this.id

  prefix_list_id = each.key
  ip_protocol    = "-1"
}

# referenced_security_group_id
resource "aws_vpc_security_group_ingress_rule" "allow_referenced_sgs" {
  for_each          = var.ingress_referenced_sg_ids
  security_group_id = aws_security_group.this.id

  referenced_security_group_id = each.key
  ip_protocol                  = "-1"
}

# Egress

# cidr_ipv4
resource "aws_vpc_security_group_egress_rule" "allow_cidr_ipv4" {
  for_each = {
    for rule in var.egress_cidrs :
    "${rule.description}-${rule.cidr_ipv4}" => rule
    if rule.cidr_ipv4 != null
  }
  security_group_id = aws_security_group.this.id

  description = each.value.description
  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port
}

# cidr_ipv6
resource "aws_vpc_security_group_egress_rule" "allow_cidr_ipv6" {
  for_each = {
    for rule in var.egress_cidrs :
    "${rule.description}-${rule.cidr_ipv6}" => rule
    if rule.cidr_ipv6 != null
  }
  security_group_id = aws_security_group.this.id

  description = each.value.description
  cidr_ipv6   = each.value.cidr_ipv6
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port
}
