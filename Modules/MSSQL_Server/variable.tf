variable "sqlserver" {
  description = "this is for sql server variable"
  type = map(object({
    sql_server_name      = string
    resource_group_name  = string
    location             = string
    version              = string
    tags                 = optional(map(string))
    kv_name              = string
    secret_name_username = string
    secret_name_password = string
  }))
}
