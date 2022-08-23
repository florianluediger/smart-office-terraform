# Terraform configuration for the Smart Office

This is the configuration for the AWS services used by the Smart Office project.

To extract the credentials that are required for connecting to IoT Core with an MQTT client, just have a look at the following outputs:

- `terraform output scd30_certificate_pem`
- `terraform output scd30_certificate_private_key`
- `terraform output zigbee2mqtt_certificate_pem`
- `terraform output zigbee2mqtt_certificate_private_key`

For connecting to the Timestream database, the user credentials can be retrieved with:

- `terraform output timestream_full_access_key_id`
- `terraform output timestream_full_access_key_secret`
