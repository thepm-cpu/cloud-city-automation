# 🪪 App Server ID Card - IAM Role
resource "aws_iam_role" "app_instance_role" {
  name = "cloud-city-app-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = "cloud-city-automation"
  }
}

# 🪪 Monitoring Server ID Card - IAM Role
resource "aws_iam_role" "monitoring_instance_role" {
  name = "cloud-city-monitoring-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = "cloud-city-automation"
  }
}

# 📋 App Server Permissions - IAM Policy
resource "aws_iam_role_policy_attachment" "app_ssm" {
  role       = aws_iam_role.app_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "app_cloudwatch" {
  role       = aws_iam_role.app_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# 📋 Monitoring Server Permissions - IAM Policy
resource "aws_iam_role_policy_attachment" "monitoring_ssm" {
  role       = aws_iam_role.monitoring_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "monitoring_cloudwatch" {
  role       = aws_iam_role.monitoring_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "monitoring_ec2" {
  role       = aws_iam_role.monitoring_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# 🔗 Instance Profiles - Attach ID Cards to Instances
resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "cloud-city-app-instance-profile"
  role = aws_iam_role.app_instance_role.name
}

resource "aws_iam_instance_profile" "monitoring_instance_profile" {
  name = "cloud-city-monitoring-instance-profile"
  role = aws_iam_role.monitoring_instance_role.name
}
