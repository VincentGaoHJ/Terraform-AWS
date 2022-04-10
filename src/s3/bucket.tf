// Bucket and ACL are the argument types for our resource.
// We can have different arguments according to our needs and their corresponding values.

# The target S3 resource
resource "aws_s3_bucket" "metas3" {
  bucket = var.bucket_name
}

# External IAM User
resource "aws_iam_user" "external_user" {
  name = "meta_external_user"
}

# Internal IAM User
resource "aws_iam_user" "internal_user" {
  name = "meta_internal_user"
}

# Generate keys for external user
resource "aws_iam_access_key" "external_user_keys" {
  user    = aws_iam_user.external_user.name
  pgp_key = "keybase:vincentgaohj"
}

# Generate keys for internal user
resource "aws_iam_access_key" "internal_user_keys" {
  user    = aws_iam_user.internal_user.name
  pgp_key = "keybase:vincentgaohj"
}

# IAM role for internal user to full control bucket
# Mention sts:AssumeRole
resource "aws_iam_role" "iam_role_internal" {
  name               = "iam_role_internal"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : aws_iam_user.internal_user.arn
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [aws_iam_policy.internal_role_policy.arn]
}

# Policy to full control s3
resource "aws_iam_policy" "internal_role_policy" {
  name   = "internal_role_policy"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = [
          aws_s3_bucket.metas3.arn,
          "${aws_s3_bucket.metas3.arn}/*"
        ]
      },
    ]
  })
}


# Grant external user access to the bucket
resource "aws_s3_bucket_policy" "external_user_bucket_policy" {
  bucket = aws_s3_bucket.metas3.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.external_user.arn}"
      },
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "${aws_s3_bucket.metas3.arn}/downloads/"
      ]
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.external_user.arn}"
      },
      "Action": [ "s3:PutObject" ],
      "Resource": [
        "${aws_s3_bucket.metas3.arn}/uploads/"
      ]
    }
  ]
}
EOF
}