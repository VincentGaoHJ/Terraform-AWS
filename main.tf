// It contains the main set of the module’s configurations.
// Here we provide details of our provider (AWS) and access key, secret key, etc.
// Since we are creating S3 using terraform modules, we need to add an S3 module to create an S3 bucket.
// For this, we will use the keyword “module” and the name of the module (folder) which we have created earlier.
// In argument, we will provide a source to the S3 module and bucket name, as we haven’t defined bucket name in var.tf.
// While writing bucket name, please keep in mind that its name is unique in the region, and it does not contain “_” or Uppercase letters.

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

module "s3" {
  source      = "./src/s3"
  bucket_name = "meta-trading-vincent-s3-bucket-demo" # bucket name should be unique
}

