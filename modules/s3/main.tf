resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl = "private"
  lifecycle_rule { 
    id = "glacier-90-day-images"
    prefix = "Images/"
    enabled = true
    expiration {
        days = 91
    }
  }
  lifecycle_rule {
    id = "delete-90-day-logs"
    prefix = "Logs/"
    enabled = true
    expiration {
      days = 91
    }
  }
}