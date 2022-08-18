output "timestream_full_access_key_id" {
  value = module.iam_timestream_full_access.aws_grafana_timestream_key_id
}

output "timestream_full_access_key_secret" {
  value = module.iam_timestream_full_access.aws_grafana_timestream_key_secret
  sensitive = true
}

output "zigbee2mqtt_certificate_pem" {
  value = module.thing_zigbee2mqtt.aws_iot_certificate_certificate_pem
  sensitive = true
}

output "zigbee2mqtt_certificate_private_key" {
  value = module.thing_zigbee2mqtt.aws_iot_certificate_private_key
  sensitive = true
}

output "scd30_certificate_pem" {
  value = module.thing_scd30.aws_iot_certificate_certificate_pem
  sensitive = true
}

output "scd30_certificate_private_key" {
  value = module.thing_scd30.aws_iot_certificate_private_key
  sensitive = true
}
