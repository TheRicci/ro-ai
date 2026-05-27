output "bot_memory_table_name" {
  description = "Name of the bot memory DynamoDB table."
  value       = aws_dynamodb_table.bot_memory.name
}

output "bot_memory_table_arn" {
  description = "ARN of the bot memory DynamoDB table."
  value       = aws_dynamodb_table.bot_memory.arn
}

output "bot_artifacts_bucket_name" {
  description = "Name of the bot artifacts S3 bucket."
  value       = aws_s3_bucket.bot_artifacts.bucket
}

output "bot_artifacts_bucket_arn" {
  description = "ARN of the bot artifacts S3 bucket."
  value       = aws_s3_bucket.bot_artifacts.arn
}
