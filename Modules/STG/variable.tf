variable "storage_account" {
  description = "variable for storage account to store state file"
  type = map(object({
    storage_account_name = string
    resource_group_name  = string
    location             = string
    account_tier         = string
    access_tier          = optional(string)
    tags                 = optional(map(string))
    network_rules = optional(map(object({
      default_action             = string
      virtual_network_subnet_ids = list(string)
      ip_rules                   = list(string)
    })))
    container_name        = string
    container_access_type = string
  }))
}
