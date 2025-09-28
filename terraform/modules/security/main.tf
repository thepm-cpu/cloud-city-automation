# 🚧 Main Estate Gate Security - ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = "cloud-city-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  # Allow HTTP from anywhere
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-city-alb-sg"
  }
}

# 🚧 App House Security - App Server Security Group
resource "aws_security_group" "app_sg" {
  name        = "cloud-city-app-sg"
  description = "Security group for application servers"
  vpc_id      = var.vpc_id

  # Allow HTTP from ALB only
  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow SSH from my IP only (for debugging)
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-city-app-sg"
  }
}

# 🚧 Monitoring House Security - Prometheus/Grafana Security Group
resource "aws_security_group" "monitoring_sg" {
  name        = "cloud-city-monitoring-sg"
  description = "Security group for monitoring server"
  vpc_id      = var.vpc_id

  # Allow SSH from my IP only
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Allow Prometheus from app servers
  ingress {
    description     = "Prometheus from app servers"
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  # Allow Grafana from my IP only
  ingress {
    description = "Grafana from my IP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-city-monitoring-sg"
  }
}
