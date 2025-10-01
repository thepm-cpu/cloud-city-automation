output "app_instance_role_arn" {
  description = "ARN of the app instance role"
  value       = aws_iam_role.app_instance_role.arn
}

output "app_instance_role_name" {
  description = "Name of the app instance role"
  value       = aws_iam_role.app_instance_role.name
}

output "monitoring_instance_role_arn" {
  description = "ARN of the monitoring instance role"
  value       = aws_iam_role.monitoring_instance_role.arn
}

output "monitoring_instance_role_name" {
  description = "Name of the monitoring instance role"
  value       = aws_iam_role.monitoring_instance_role.name
}

output "app_instance_profile_name" {
  description = "Name of the app instance profile"
  value       = aws_iam_instance_profile.app_instance_profile.name
}

output "monitoring_instance_profile_name" {
  description = "Name of the monitoring instance profile"
  value       = aws_iam_instance_profile.monitoring_instance_profile.name
}