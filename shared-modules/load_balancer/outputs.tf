# Load Balancer Outputs
output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "load_balancer_zone_id" {
  description = "Zone ID of the load balancer"
  value       = aws_lb.this.zone_id
}

output "load_balancer_type" {
  description = "Type of the load balancer"
  value       = aws_lb.this.load_balancer_type
}

# Target Group Outputs
output "target_group_arns" {
  description = "ARNs of the target groups"
  value       = { for k, v in aws_lb_target_group.this : k => v.arn }
}

output "target_groups" {
  description = "Target groups of the load balancer"
  value       = aws_lb_target_group.this
}

output "target_group_names" {
  description = "Names of the target groups"
  value       = { for k, v in aws_lb_target_group.this : k => v.name }
}

output "target_group_arn_suffixes" {
  description = "ARN suffixes of the target groups"
  value       = { for k, v in aws_lb_target_group.this : k => v.arn_suffix }
}

# Listener Outputs
output "listener_arns" {
  description = "ARNs of the listeners"
  value       = { for k, v in aws_lb_listener.this : k => v.arn }
}

output "listener_rule_arns" {
  description = "ARNs of the listener rules"
  value       = { for k, v in aws_lb_listener_rule.this : k => v.arn }
}
