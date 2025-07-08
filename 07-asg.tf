# Auto Scaling Group
resource "aws_autoscaling_group" "app" {
  name_prefix = "app-asg-"
  vpc_zone_identifier = aws_subnet.private[*].id
  target_group_arns = [aws_lb_target_group.app.arn]
  min_size = var.asg_min_size
  max_size = var.asg_max_size
  desired_capacity = var.asg_desired_capacity
  health_check_type = "ELB"
  health_check_grace_period = 10

  launch_template {
    id = aws_launch_template.app.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup = 5
    }
  }

  tag {
    key = "Name"
    value = "app-instance"
    propagate_at_launch = true
  }
}

# Auto Scaling Policy
resource "aws_autoscaling_policy" "cpu_tracking" {
  name = "cpu-tracking-policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.app.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}
