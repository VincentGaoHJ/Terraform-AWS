# The target S3 resource
resource "aws_s3_bucket" "metas3" {
  bucket = var.source_bucket
}