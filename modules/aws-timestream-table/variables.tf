variable "database_name" {
  type = string
}

variable "table_name" {
  type = string
}

variable "magnetic_store_retention_period_in_days" {
  default = 365
}
variable "memory_store_retention_period_in_hours" {
  default = 24
}