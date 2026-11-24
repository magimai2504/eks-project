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