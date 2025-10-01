# AWS Region
region = "eu-north-1"

# VPC Configuration
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
azs = ["eu-north-1a", "eu-north-1b"]

# Environment
environment = "production"

# Your IP address (will be passed via GitHub Secrets)
my_ip = "CHANGE_ME"  # This will be overridden by GitHub Actions

# Instance Types
app_instance_type = "t3.micro"
monitoring_instance_type = "t3.small"

# Auto Scaling
desired_capacity = 2
max_size = 4
min_size = 1

# Key Pair
key_name = "devops-key"