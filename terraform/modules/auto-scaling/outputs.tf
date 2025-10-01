output "auto_scaling_group_id" {
  description = "ID of the auto scaling group"
  value       = aws_autoscaling_group.app_asg.id
}

output "auto_scaling_group_name" {
  description = "Name of the auto scaling group"
  value       = aws_autoscaling_group.app_asg.name
}

output "auto_scaling_group_arn" {
  description = "ARN of the auto scaling group"
  value       = aws_autoscaling_group.app_asg.arn
}

output "scale_up_policy_arn" {
  description = "ARN of the scale up policy"
  value       = aws_autoscaling_policy.scale_up.arn
}

output "scale_down_policy_arn" {
  description = "ARN of the scale down policy"
  value       = aws_autoscaling_policy.scale_down.arn
}

output "high_cpu_alarm_arn" {
  description = "ARN of the high CPU alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu.arn
}

output "low_cpu_alarm_arn" {
  description = "ARN of the low CPU alarm"
  value       = aws_cloudwatch_metric_alarm.low_cpu.arn
}