locals {
  database_name = "smart_office"
  table_zigbee2mqtt = "zigbee2mqtt"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}

# Create timestream database to save all kinds of sensor data
module "timestream_database" {
  source = "./modules/aws-timestream-database"
  database_name = local.database_name
}

# Create timestream table for saving the data provided by zigbee2mqtt
module "timestream_sensordata" {
  source = "./modules/aws-timestream-table"
  database_name = local.database_name
  table_name = local.table_zigbee2mqtt
}

# Create admin policy to allow access the IoT Core MQTT server from outside
module "iot_admin_policy" {
  source = "./modules/aws-iot-admin-policy"
}

# Create thing to represent all data that is provided by zigbee2mqtt
# This will also create a certificate that can be used to connect with the thing via mqtt
module "thing_zigbee2mqtt" {
  source = "./modules/aws-iot-thing"
  name = "zigbee2mqtt"
  policy_name = module.iot_admin_policy.policy_name
}

# Create role that can write to all timestream databases
module "iam_timestream_writer" {
  source = "./modules/aws-iam-timestream-writer"
  table_arn = module.timestream_sensordata.table_arn
}

# Create role to save all messages from zigbee2mqtt into the timestream database
module "iot_rule_zigbee2mqtt_to_timestream" {
  source = "./modules/aws-iot-rule"
  name = "Zigbee2MqttToTimestream"
  database_name = local.database_name
  table_name = local.table_zigbee2mqtt
  sql = "SELECT * FROM 'zigbee2mqtt/#' WHERE topic(2) <> 'bridge'"
  role_arn = module.iam_timestream_writer.role_arn
  dimension_name = "device"
  dimension_value = "$${topic(2)}"
}

# Create user that has full access to the timestream database
# This will be used by the grafana dashboard
module "iam_timestream_full_access" {
  source = "./modules/aws-iam-timestream-full-access"
}