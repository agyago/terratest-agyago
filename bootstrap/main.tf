terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = terraformstatefile
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "main" {
  name = terraformstatefile
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