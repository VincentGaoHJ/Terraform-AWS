//the arn of the user that was created
output "external_user_arn" {
  value = aws_iam_user.external_user.arn
}

//the name of the service account user that was created
output "external_user_name" {
  value = aws_iam_user.external_user.name
}

//the arn of the bucket that was created
output "bucket_arn" {
  value = aws_s3_bucket.metas3.arn
}

//the name of the bucket
output "bucket_name" {
  value = aws_s3_bucket.metas3.id
}

//the access key
output "external_user_iam_access_key_id" {
  value = aws_iam_access_key.external_user_keys.id
}

//the access key secret
output "external_user_iam_access_key_secret" {
  value = aws_iam_access_key.external_user_keys.encrypted_secret
}