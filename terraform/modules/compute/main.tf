# 🏠 Application House - App Server Launch Template
resource "aws_launch_template" "app_server" {
  name_prefix   = "cloud-city-app-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.app_instance_type
  key_name      = var.key_name
  
  iam_instance_profile {
    name = aws_iam_instance_profile.app_instance_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.app_security_group_id]
  }

  user_data = base64encode(templatefile("${path.module}/user-data/app-user-data.sh", {
    app_name = var.app_name
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "cloud-city-app-server"
      Project = "cloud-city-automation"
      Role    = "app"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 🏠 Monitoring House - Prometheus/Grafana Server
resource "aws_instance" "monitoring_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.monitoring_instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.monitoring_security_group_id]
  key_name               = var.key_name
  
  iam_instance_profile {
    name = aws_iam_instance_profile.monitoring_instance_profile.name
  }

  user_data = base64encode(templatefile("${path.module}/user-data/monitoring-user-data.sh", {
    prometheus_version = var.prometheus_version
    grafana_version    = var.grafana_version
  }))

  tags = {
    Name    = "cloud-city-monitoring-server"
    Project = "cloud-city-automation"
    Role    = "monitoring"
  }

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  depends_on = [aws_iam_instance_profile.monitoring_instance_profile]
}

# 🔍 Find the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-22.04-*-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
