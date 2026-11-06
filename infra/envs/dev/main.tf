terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65"
    }
  }

  backend "s3" {
    bucket = "terraform-state-${var.project_name}-dev"
    key    = "envs/dev/terraform.tfstate"
    region = var.aws_region
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "development"
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}

module "orders_service" {
  source = "../../modules/orders_service"

  environment           = "dev"
  project_name          = var.project_name
  aws_region            = var.aws_region
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  db_instance_class     = "db.t3.micro"
  ecs_cluster_name      = "${var.project_name}-orders-dev"
  ecs_desired_count     = 1
  ecs_cpu              = 256
  ecs_memory           = 512
  alb_name             = "${var.project_name}-orders-dev"
  s3_bucket_name       = "${var.project_name}-orders-dev"
  log_retention_days   = 7
}