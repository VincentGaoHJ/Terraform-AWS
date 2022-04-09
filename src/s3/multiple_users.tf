resource "aws_iam_user" "multiple_users" {
  for_each = toset(var.multiple_user_lst)
  name     = each.value
}

resource "aws_iam_user_policy" "multiple_user_policy" {
  for_each = toset(var.multiple_user_lst)
  name     = "multiple_user_policy"
  user     = each.value
  policy   = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = [
          "${aws_s3_bucket.metas3.arn}/downloads/${each.value}",
          "${aws_s3_bucket.metas3.arn}/downloads/${each.value}/*",
          "${aws_s3_bucket.metas3.arn}/downloads/common",
          "${aws_s3_bucket.metas3.arn}/downloads/common/*"
        ]
      },
      {
        Action = [
          "s3:PutObject",
        ]
        Effect   = "Allow"
        Resource = [
          "${aws_s3_bucket.metas3.arn}/uploads/${each.value}",
          "${aws_s3_bucket.metas3.arn}/uploads/${each.value}/*"
        ]
      },
    ]
  })
}