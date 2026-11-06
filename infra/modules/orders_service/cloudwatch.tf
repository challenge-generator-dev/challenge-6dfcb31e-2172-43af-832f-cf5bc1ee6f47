# Alarmas y métricas de CloudWatch para monitorear el servicio de órdenes
# SUPERFICIE DE PRÁCTICA: configurar umbrales y acciones de las alarmas

# Grupo de logs para el servicio
resource "aws_cloudwatch_log_group" "orders_service" {
  name              = "/aws/orders-service/${var.environment}"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "orders-service-logs"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Métrica personalizada: órdenes procesadas por minuto
resource "aws_cloudwatch_metric_alarm" "orders_processed_rate" {
  alarm_name          = "${var.project_name}-orders-processed-rate-${var.environment}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "OrdersProcessed"
  namespace           = "OrdersService"
  period              = "60"
  statistic           = "Sum"
  threshold           = var.min_orders_per_minute
  alarm_description   = "Alerta cuando el número de órdenes procesadas está por debajo del umbral mínimo"
  treat_missing_data  = "breaching"

  tags = {
    Name        = "orders-processed-rate-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Alarma de latencia promedio de procesamiento
resource "aws_cloudwatch_metric_alarm" "processing_latency" {
  alarm_name          = "${var.project_name}-processing-latency-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "ProcessingLatency"
  namespace           = "OrdersService"
  period              = "300"
  statistic           = "Average"
  threshold           = var.max_processing_latency_ms
  alarm_description   = "Alerta cuando la latencia de procesamiento supera el umbral máximo"
  treat_missing_data  = "missing"

  tags = {
    Name        = "processing-latency-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Alarma de tasa de errores
resource "aws_cloudwatch_metric_alarm" "error_rate" {
  alarm_name          = "${var.project_name}-error-rate-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "ErrorRate"
  namespace           = "OrdersService"
  period              = "60"
  statistic           = "Average"
  threshold           = var.max_error_rate_percent
  alarm_description   = "Alerta cuando la tasa de errores supera el umbral permitido"
  treat_missing_data  = "breaching"

  tags = {
    Name        = "error-rate-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Alarma de uso de CPU del ECS
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization" {
  alarm_name          = "${var.project_name}-ecs-cpu-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.max_cpu_utilization_percent
  alarm_description   = "Alerta cuando el uso de CPU del cluster ECS supera el 80%"
  dimensions = {
    ClusterName = var.ecs_cluster_name
  }

  tags = {
    Name        = "ecs-cpu-utilization-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Alarma de uso de memoria del ECS
resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization" {
  alarm_name          = "${var.project_name}-ecs-memory-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.max_memory_utilization_percent
  alarm_description   = "Alerta cuando el uso de memoria del cluster ECS supera el 80%"
  dimensions = {
    ClusterName = var.ecs_cluster_name
  }

  tags = {
    Name        = "ecs-memory-utilization-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Dashboard de CloudWatch para el servicio
resource "aws_cloudwatch_dashboard" "orders_service" {
  dashboard_name = "${var.project_name}-orders-service-${var.environment}"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["OrdersService", "OrdersProcessed", {"stat" = "Sum"}],
            [".", ".", {"stat" = "Sum"}]
          ]
          period  = 60
          stat    = "Sum"
          region  = var.aws_region
          title   = "Órdenes Procesadas"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["OrdersService", "ProcessingLatency", {"stat" = "Average"}],
            [".", ".", {"stat" = "Maximum"}]
          ]
          period  = 300
          stat    = "Average"
          region  = var.aws_region
          title   = "Latencia de Procesamiento"
        }
      }
    ]
  })
}