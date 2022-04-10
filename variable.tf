variable "region" {
  default = "ap-southeast-1"
}

variable "multiple_exist_user_lst" {
  default = ["meta_exist1", "meta_exist2", "meta_exist3"]
}

variable "s3_bucket_name" {
  default = "meta-trading-vincent-s3-bucket-demo"
}

variable "source_bucket" {
  default = "meta-trading-vincent-source-s3-for-sync"
}