resource "aws_eks_node_group" "main" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-${var.environment}-workers"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

  instance_types = [var.instance_type]
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name        = "${var.project_name}-worker-nodes"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}