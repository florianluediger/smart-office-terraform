resource "aws_s3_bucket" "terraform_state" {
  bucket = "smart-office-terraform-state"

  # prevent accidental deletion
  lifecycle {
    prevent_destroy = true
  }
}

# enable bucket versioning
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# enable encryption of the terraform state
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# prevent public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# set access control list for bucket
resource "aws_s3_bucket_acl" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

# access policy for the bucket
data "aws_iam_policy_document" "s3_access" {
  statement {
    effect    = "Allow"
    resources = [aws_s3_bucket.terraform_state.arn]
    actions   = ["s3:ListBucket"]
  }

  statement {
    effect    = "Allow"
    resources = ["${aws_s3_bucket.terraform_state.arn}/*"]
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
  }
}
