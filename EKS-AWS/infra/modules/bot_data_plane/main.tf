resource "aws_dynamodb_table" "bot_memory" {
  name         = var.bot_memory_table_name
  billing_mode = var.bot_memory_billing_mode
  hash_key     = var.bot_memory_partition_key
  range_key    = var.bot_memory_sort_key

  attribute {
    name = var.bot_memory_partition_key
    type = "S"
  }

  attribute {
    name = var.bot_memory_sort_key
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  server_side_encryption {
    enabled = true
  }

  tags = merge(
    var.tags,
    {
      Name = var.bot_memory_table_name
    }
  )
}

resource "aws_s3_bucket" "bot_artifacts" {
  bucket = var.bot_artifacts_bucket_name

  tags = merge(
    var.tags,
    {
      Name = var.bot_artifacts_bucket_name
    }
  )
}

resource "aws_s3_bucket_public_access_block" "bot_artifacts" {
  bucket = aws_s3_bucket.bot_artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bot_artifacts" {
  bucket = aws_s3_bucket.bot_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "bot_artifacts" {
  bucket = aws_s3_bucket.bot_artifacts.id

  versioning_configuration {
    status = var.enable_bucket_versioning ? "Enabled" : "Suspended"
  }
}
