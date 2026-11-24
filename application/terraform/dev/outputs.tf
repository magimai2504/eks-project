
output "aws_account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "artifacts_bucket_name" {
  description = "S3 artifacts bucket"
  value       = aws_s3_bucket.project_artifacts.bucket
}