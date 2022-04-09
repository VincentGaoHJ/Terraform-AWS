// Bucket and ACL are the argument types for our resource.
// We can have different arguments according to our needs and their corresponding values.

resource "aws_s3_bucket" "metas3" {
  bucket = var.bucket_name
}