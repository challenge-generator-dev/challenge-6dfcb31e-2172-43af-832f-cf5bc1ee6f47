terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65"
    }
  }

  backend "s3" {
    bucket = "terraform-state-${var.project_name}-prod"
    key    = "envs/prod/terraform.tfstate"
    region = var.aws_region
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "production"
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}

module "orders_service" {
  source = "../../modules/orders_service"

  environment           = "prod"
  project_name          = var.project_name
  aws_region            = var.aws_region
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  db_instance_class     = "db.t3.medium"
  ecs_cluster_name      = "${var.project_name}-orders-prod"
  ecs_desired_count     = 3
  ecs_cpu              = 1024
  ecs_memory           = 2048
  alb_name             = "${var.project_name}-orders-prod"
  s3_bucket_name       = "${var.project_name}-orders-prod"
  log_retention_days   = 30
}