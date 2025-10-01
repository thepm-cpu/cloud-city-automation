# Outputs for the entire infrastructure
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.load_balancer.alb_dns_name
}

output "monitoring_server_ip" {
  description = "Public IP address of the monitoring server"
  value       = module.compute.monitoring_server_ip
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "app_security_group_id" {
  description = "Security group ID for app servers"
  value       = module.security.app_sg_id
}

output "monitoring_security_group_id" {
  description = "Security group ID for monitoring server"
  value       = module.security.monitoring_sg_id
}

output "alb_security_group_id" {
  description = "Security group ID for ALB"
  value       = module.security.alb_sg_id
}

output "app_launch_template_id" {
  description = "ID of the app launch template"
  value       = module.compute.app_launch_template_id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.load_balancer.target_group_arn
}

output "auto_scaling_group_name" {
  description = "Name of the auto scaling group"
  value       = module.auto_scaling.auto_scaling_group_name
}