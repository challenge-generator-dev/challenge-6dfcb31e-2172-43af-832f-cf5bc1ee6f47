# Configuración del Application Load Balancer para el servicio de órdenes
# Este módulo define el ALB que distribuye el tráfico al servicio ECS

# ========================================
# ALB Security Group
# ========================================
resource "aws_security_group" "alb" {
  name        = "orders-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}

# ========================================
# Application Load Balancer
# ========================================
resource "aws_lb" "orders" {
  name               = "orders-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = var.environment == "prod"

  access_logs {
    bucket  = var.alb_log_s3_bucket
    prefix  = "orders-alb"
    enabled = true
  }

  tags = var.common_tags
}

# ========================================
# Target Group para el servicio ECS
# ========================================
resource "aws_lb_target_group" "orders" {
  name     = "orders-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = var.health_check_path
    matcher             = "200"
  }

  stickiness {
    enabled = true
    type    = "lb_cookie"
    cookie_duration = 86400
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.common_tags
}

# ========================================
# Listener HTTP (redirige a HTTPS)
# ========================================
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.orders.arn
  port              = "80"
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

# ========================================
# Listener HTTPS
# ========================================
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.orders.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orders.arn
  }
}

# ========================================
# Listener Rule para métricas
# ========================================
resource "aws_lb_listener_rule" "metrics" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.orders.arn
  }

  condition {
    path_pattern {
      values = ["/metrics*", "/health*", "/ready*"]
    }
  }
}

# ========================================
# Listener Rule para API orders
# ========================================
resource "aws_lb_listener_rule" "api_orders" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 1

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.orders.arn
  }

  condition {
    path_pattern {
      values = ["/api/orders/*", "/api/orders"]
    }
  }
}