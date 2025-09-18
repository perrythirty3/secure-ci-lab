resource "random_id" "suffix" { byte_length = 2 }

resource "aws_s3_bucket" "logs" {
  bucket        = "p-secure-ci-lab-logs-${random_id.suffix.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}