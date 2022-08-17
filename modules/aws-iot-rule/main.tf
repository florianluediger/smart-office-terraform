resource "aws_iot_topic_rule" "ToTimestream" {
  name        = var.name
  enabled     = true
  sql         = var.sql
  sql_version = "2016-03-23"
  timestream {
    database_name = var.database_name
    role_arn      = var.role_arn
    table_name    = var.table_name
    dimension {
      name  = var.dimension_name
      value = var.dimension_value
    }
  }
}