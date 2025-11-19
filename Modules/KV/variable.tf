variable "key_vault" {
  description = "this is for variable in key vault"
  type = map(object({
    keyvault_name               = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = optional(bool)
    soft_delete_retention_days  = optional(number)
    purge_protection_enabled    = optional(bool)
    sku_name                    = string
    access_policy = list(object({
      key_permissions     = list(string)
      secret_permissions  = list(string)
      storage_permissions = list(string)
    }))
    username_secret = object({
      name  = string
      value = string
    })
    password_secret = object({
      name  = string
      value = string
    })
  }))
}
