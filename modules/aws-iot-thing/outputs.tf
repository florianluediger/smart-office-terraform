output "aws_iot_certificate_certificate_pem" {
  value = aws_iot_certificate.cert.certificate_pem
  sensitive = true
}

output "aws_iot_certificate_private_key" {
  value = aws_iot_certificate.cert.private_key
  sensitive = true
}

output "aws_iot_certificate_arn" {
  value = aws_iot_certificate.cert.arn
}