//the arn of the user that was created
output "external_user_arn" {
  value = module.s3.external_user_arn
}

//the name of the service account user that was created
output "external_user_name" {
  value = module.s3.external_user_name
}

//the arn of the bucket that was created
output "bucket_arn" {
  value = module.s3.bucket_arn
}

//the name of the bucket
output "bucket_name" {
  value = module.s3.bucket_name
}

//the access key
output "external_user_iam_access_key_id" {
  value = module.s3.external_user_iam_access_key_id
}

//the access key secret
output "external_user_iam_access_key_secret" {
  value = module.s3.external_user_iam_access_key_secret
}

//Multiple user list
output "multiple_users" {
  value = module.s3.multiple_users
}

// Policy for multiple created users
output "multiple_user_policy_arn" {
  value = module.s3.multiple_user_policy_arn
}


// Lambda Arn
output "meta_schedule_lambda_arn" {
  value = module.sync.meta_schedule_lambda_arn
}