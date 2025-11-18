variable "mssql_database" {
  description = "this is mssql database variable"
  type = map(object({
    mssql_database_name = string
    collation           = optional(string)
    license_type        = optional(string)
    max_size_gb         = optional(number)
    sku_name            = optional(string)
    enclave_type        = optional(string)
    tags                = optional(map(string))
    mssql_server_name   = string
    resource_group_name = string
  }))
}
