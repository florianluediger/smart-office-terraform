output "aws_grafana_timestream_key_id" {
  value = aws_iam_access_key.TimestreamFullAccessKey.id
}

output "aws_grafana_timestream_key_secret" {
  value = aws_iam_access_key.TimestreamFullAccessKey.secret
  sensitive = true
}