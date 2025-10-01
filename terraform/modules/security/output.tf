output "alb_sg_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb_sg.id
}

output "app_sg_id" {
  description = "Security group ID for app servers"
  value       = aws_security_group.app_sg.id
}

output "monitoring_sg_id" {
  description = "Security group ID for monitoring server"
  value       = aws_security_group.monitoring_sg.id
}

output "alb_sg_name" {
  description = "Name of the ALB security group"
  value       = aws_security_group.alb_sg.name
}

output "app_sg_name" {
  description = "Name of the app security group"
  value       = aws_security_group.app_sg.name
}

output "monitoring_sg_name" {
  description = "Name of the monitoring security group"
  value       = aws_security_group.monitoring_sg.name
}