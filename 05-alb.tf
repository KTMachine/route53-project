# Application Load Balancer
resource "aws_lb" "app" {
  name = "app-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = aws_subnet.public[*].id

  enable_deletion_protection = false

  tags = {
    Name = "app-alb"
  }
}

# ALB Target Group
resource "aws_lb_target_group" "app" {
  name = "app-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id

  health_check {
    enabled = true
    interval = 30
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 10
    healthy_threshold = 3
    unhealthy_threshold = 3
    matcher = "200-399"
  }
}

# ALB Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}