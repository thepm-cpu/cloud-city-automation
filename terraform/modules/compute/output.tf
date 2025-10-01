output "app_launch_template_id" {
  description = "ID of the app launch template"
  value       = aws_launch_template.app_server.id
}

output "app_launch_template_name" {
  description = "Name of the app launch template"
  value       = aws_launch_template.app_server.name
}

output "app_launch_template_latest_version" {
  description = "Latest version of the app launch template"
  value       = aws_launch_template.app_server.latest_version
}

output "monitoring_server_id" {
  description = "ID of the monitoring server instance"
  value       = aws_instance.monitoring_server.id
}

output "monitoring_server_ip" {
  description = "Public IP address of the monitoring server"
  value       = aws_instance.monitoring_server.public_ip
}

output "monitoring_server_private_ip" {
  description = "Private IP address of the monitoring server"
  value       = aws_instance.monitoring_server.private_ip
}

output "ubuntu_ami_id" {
  description = "ID of the Ubuntu AMI used"
  value       = data.aws_ami.ubuntu.id
}