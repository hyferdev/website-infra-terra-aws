# Target Group
resource "aws_lb_target_group" "hyfer-tg" {
  name     = "hyfer-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = var.tags
}

# Register Instances to Target Group
resource "aws_lb_target_group_attachment" "hyfer-tg-register" {
  for_each = toset(var.target_instance_ids)

  target_group_arn = aws_lb_target_group.hyfer-tg.arn
  target_id        = each.key
  port             = 80
}

# Load Balancer
resource "aws_lb" "hyfer-alb" {
  name               = "hyfer-alb"
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [] # we will leave it open to the world by default (can fix later)

  tags = var.tags
}

# Listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.hyfer-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyfer-tg.arn
  }
}

