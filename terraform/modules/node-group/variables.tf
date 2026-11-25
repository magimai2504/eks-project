variable "cluster_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "m7i-flex.large"
}