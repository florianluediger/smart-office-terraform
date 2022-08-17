resource "aws_timestreamwrite_database" "this" {
  database_name = var.database_name
}