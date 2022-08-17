resource "aws_iot_thing" "this" {
  name = var.name
}

resource "aws_iot_certificate" "cert" {
  active = true
}

resource "aws_iot_policy_attachment" "policy_attachment" {
  policy = var.policy_name
  target = aws_iot_certificate.cert.arn
}

resource "aws_iot_thing_principal_attachment" "certificate_attachment" {
  principal = aws_iot_certificate.cert.arn
  thing     = aws_iot_thing.this.name
}