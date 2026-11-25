variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "allowed_api_cidrs" {
  type = list(string)
}