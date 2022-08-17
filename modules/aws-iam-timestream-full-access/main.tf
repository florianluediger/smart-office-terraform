resource "aws_iam_user" "TimestreamFullAccess" {
  name = "timestream_full_access"
}

resource "aws_iam_user_policy" "TimestreamFullAccess" {
  user   = aws_iam_user.TimestreamFullAccess.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
          "timestream:*"
        ],
        "Resource": "*"
      },
    ]
  })
}

resource "aws_iam_access_key" "TimestreamFullAccessKey" {
  user = aws_iam_user.TimestreamFullAccess.name
}