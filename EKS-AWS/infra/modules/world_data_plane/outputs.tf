output "db_instance_identifier" {
  description = "Identifier of the world database instance."
  value       = aws_db_instance.world.identifier
}

output "db_address" {
  description = "Endpoint address of the world database."
  value       = aws_db_instance.world.address
}

output "db_port" {
  description = "Port of the world database."
  value       = aws_db_instance.world.port
}

output "secret_name" {
  description = "Secrets Manager secret name for the world database connection."
  value       = aws_secretsmanager_secret.world_db.name
}

output "secret_arn" {
  description = "Secrets Manager secret ARN for the world database connection."
  value       = aws_secretsmanager_secret.world_db.arn
}
