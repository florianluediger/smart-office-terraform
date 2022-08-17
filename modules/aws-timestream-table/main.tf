resource "aws_timestreamwrite_table" "this" {
  database_name = var.database_name
  table_name = var.table_name

  retention_properties {
    magnetic_store_retention_period_in_days = var.magnetic_store_retention_period_in_days
    memory_store_retention_period_in_hours  = var.memory_store_retention_period_in_hours
  }
}