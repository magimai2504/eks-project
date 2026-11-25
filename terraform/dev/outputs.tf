
output "aws_account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "artifacts_bucket_name" {
  description = "S3 artifacts bucket"
  value       = aws_s3_bucket.project_artifacts.bucket
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "eks_cluster_role_arn" {
  description = "EKS cluster IAM role ARN"
  value       = module.eks_iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  description = "EKS worker node IAM role ARN"
  value       = module.eks_iam.eks_node_role_arn
}