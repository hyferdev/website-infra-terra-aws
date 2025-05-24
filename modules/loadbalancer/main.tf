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
  for_each = var.target_instance_ids

  target_group_arn = aws_lb_target_group.hyfer-tg.arn
  target_id        = each.value
  port             = 80
}

# Load Balancer Security Group
resource "aws_security_group" "alb_sg" {
  name        = "hyfer-alb-sg"
  description = "Allow HTTP and HTTPS to ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "hyfer-alb-sg"
  })
}

# Load Balancer
resource "aws_lb" "hyfer-alb" {
  name               = "hyfer-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [aws_security_group.alb_sg.id]

  tags = var.tags
}

# Listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.hyfer-alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyfer-tg.arn
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.hyfer-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

