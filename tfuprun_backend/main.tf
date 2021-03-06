provider "aws" {
  profile = "default"
  region = "us-east-2"
}

resource "aws_s3_bucket" "terrafrom_state" {
  bucket = "tfuprun-state"
  
//   # Prevent accidental deletion of this s3 bucket
//   lifecyle {
//     prevent_destroy = true
//   }
  
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
      Name = "terraform-example-s3-state",
      QarikUser = "channa"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tfuprun-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
      Name = "terraform-example-s3-state",
      QarikUser = "channa"
  }

}
