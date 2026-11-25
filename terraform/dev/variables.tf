
variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "eks-gitops-platform"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "eks_api_allowed_cidrs" {
  description = "Public IP addresses allowed to access the EKS API"
  type        = list(string)
}


variable "instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "m7i-flex.large"
}