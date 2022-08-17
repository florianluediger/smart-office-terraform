resource "aws_iam_role" "TimestreamWriter" {
  name = "TimestreamWriter"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "iot.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "TimestreamWriter" {
  name = "TimestreamWriter"
  role   = aws_iam_role.TimestreamWriter.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "timestream:WriteRecords"
        ],
        "Resource": var.table_arn
      },
      {
        "Effect": "Allow",
        "Action": [
          "timestream:DescribeEndpoints"
        ],
        "Resource": "*"
      }
    ]
  })
}