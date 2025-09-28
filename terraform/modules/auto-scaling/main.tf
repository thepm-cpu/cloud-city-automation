# 👷 Emergency Builders - Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  name_prefix         = "cloud-city-asg-"
  vpc_zone_identifier = var.public_subnet_ids
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  # Health check settings
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "cloud-city-app-server"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "cloud-city-automation"
    propagate_at_launch = true
  }

  tag {
    key                 = "Role"
    value               = "app"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }
}

# 📈 Scaling Policies - When to build more houses
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "cloud-city-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "cloud-city-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
}

# 🔔 CloudWatch Alarms - When to trigger scaling
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "cloud-city-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }

  alarm_description = "Scale up if CPU > 70% for 2 periods"
  alarm_actions     = [aws_autoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "cloud-city-low-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }

  alarm_description = "Scale down if CPU < 30% for 2 periods"
  alarm_actions     = [aws_autoscaling_policy.scale_down.arn]
}
