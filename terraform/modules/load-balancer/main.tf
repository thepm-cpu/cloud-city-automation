# 🚦 Traffic Police - Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "cloud-city-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name    = "cloud-city-alb"
    Project = "cloud-city-automation"
  }
}

# 🎯 Target Group - Where to send traffic
resource "aws_lb_target_group" "app_tg" {
  name     = "cloud-city-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name    = "cloud-city-tg"
    Project = "cloud-city-automation"
  }
}

# 📍 Traffic Rules - Listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  tags = {
    Name    = "cloud-city-listener"
    Project = "cloud-city-automation"
  }
}
