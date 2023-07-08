resource "aws_s3_bucket" "tf_state" {
  bucket = var.backend_bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.tf_state.id

    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_dynamodb_table" "main" {
  name = var.dynamic_table
  hash_key = "LockID"
  write_capacity = 1
  read_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }
   lifecycle {
    prevent_destroy = true
  }
  tags = {
    Description = "Terraform state lock table"
    ManagedByTerraform = "true"
  }
}