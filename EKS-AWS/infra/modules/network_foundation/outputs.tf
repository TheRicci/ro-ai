output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "world_db_security_group_id" {
  description = "Security group ID intended for the world database."
  value       = aws_security_group.world_db.id
}
