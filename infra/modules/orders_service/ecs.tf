# Configuración del servicio ECS para el servicio de órdenes
# Este módulo define el cluster ECS y la task definition necesaria para ejecutar el servicio

# ========================================
# ECS Cluster
# ========================================
resource "aws_ecs_cluster" "orders" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = var.common_tags
}

# ========================================
# Task Definition
# ========================================
resource "aws_ecs_task_definition" "orders" {
  family                   = "orders-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "orders-service"
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "ENV", value = var.environment },
        { name = "LOG_LEVEL", value = var.log_level }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/orders-service"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = var.common_tags
}

# ========================================
# ECS Service
# ========================================
resource "aws_ecs_service" "orders" {
  name            = "orders-service"
  cluster         = aws_ecs_cluster.orders.id
  task_definition = aws_ecs_task_definition.orders.arn
  desired_count   = var.service_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "orders-service"
    container_port   = var.container_port
  }

  depends_on = [aws_lb_target_group.orders]

  deployment_controller {
    type = "ECS"
  }

  tags = var.common_tags
}

# ========================================
# IAM Roles para ECS
# ========================================
resource "aws_iam_role" "ecs_execution_role" {
  name = "orders-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "orders-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# ========================================
# Security Group para las tareas ECS
# ========================================
resource "aws_security_group" "ecs_tasks" {
  name        = "orders-ecs-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}