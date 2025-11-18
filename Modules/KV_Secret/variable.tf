variable "kv_secret" {
  description = "key vault secret variable file"
  type = map(object({
    name                = string
    value               = string
    keyvault_name       = string
    resource_group_name = string
  }))
}
