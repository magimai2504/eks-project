data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "project_artifacts" {
  bucket = "${var.project_name}-${var.environment}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${var.project_name}-artifacts"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "project_artifacts" {
  bucket = aws_s3_bucket.project_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

module "vpc" {
  source = "../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

module "eks_iam" {
  source = "../modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

module "eks_cluster" {
  source = "../modules/eks-cluster"

  project_name       = var.project_name
  environment        = var.environment
  cluster_role_arn   = module.eks_iam.eks_cluster_role_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  allowed_api_cidrs  = var.eks_api_allowed_cidrs

  depends_on = [module.eks_iam]
}


module "node_group" {
  source = "../modules/node-group"

  cluster_name       = module.eks_cluster.cluster_name
  project_name       = var.project_name
  environment        = var.environment
  node_role_arn      = module.eks_iam.eks_node_role_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type      = "m7i-flex.large"

  depends_on = [
    module.eks_cluster,
    module.eks_iam
  ]
}