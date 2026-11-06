# AWS Credentials (should be provided via environment variables or AWS CLI)
aws_region = "us-east-1"

# Network Configuration
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

# ECS Configuration
ecs_cluster_name = "orders-service-dev"
ec2_instance_type = "t3.medium"
min_capacity = 1
max_capacity = 2

# RDS Configuration
rds_instance_class = "db.t3.micro"
rds_engine_version = "15.5"
rds_allocated_storage = 20
rds_username = "orders_admin"
rds_password = "secure_password_123!"
rds_database_name = "orders_dev"

# ALB Configuration
alb_name = "orders-service-alb-dev"

# S3 Configuration
s3_bucket_name = "orders-service-uploads-dev"

# CloudWatch Logs
cloudwatch_log_group_name = "/ecs/orders-service-dev"

# Tags
environment = "dev"
project     = "orders-service"