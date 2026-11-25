# Trust policy for the EKS cluster
data "aws_iam_policy_document" "eks_cluster_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# EKS cluster IAM role
resource "aws_iam_role" "eks_cluster" {
  name               = "${var.project_name}-${var.environment}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json

  tags = {
    Name        = "${var.project_name}-eks-cluster-role"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Attach the required cluster policy
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Trust policy for EC2 worker nodes
data "aws_iam_policy_document" "eks_node_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# EKS worker node IAM role
resource "aws_iam_role" "eks_node" {
  name               = "${var.project_name}-${var.environment}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role.json

  tags = {
    Name        = "${var.project_name}-eks-node-role"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Worker node permissions
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Permission to pull container images from ECR
resource "aws_iam_role_policy_attachment" "eks_ecr_policy" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

# VPC CNI networking permissions
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}