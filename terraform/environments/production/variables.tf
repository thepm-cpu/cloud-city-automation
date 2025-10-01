variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b"]
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "my_ip" {
  description = "Your IP address for SSH access"
  type        = string
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
  default     = "devops-key"
}

variable "app_instance_type" {
  description = "Instance type for app servers"
  type        = string
  default     = "t3.micro"
}

variable "monitoring_instance_type" {
  description = "Instance type for monitoring server"
  type        = string
  default     = "t3.small"
}

variable "desired_capacity" {
  description = "Desired number of app instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of app instances"
  type        = number
  default     = 4
}

variable "min_size" {
  description = "Minimum number of app instances"
  type        = number
  default     = 1
}