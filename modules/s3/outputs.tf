output "s3_bucket_name" {
  description = "Full name of S3 bucket that was created"
  value = aws_s3_bucket.s3_bucket.id
}
