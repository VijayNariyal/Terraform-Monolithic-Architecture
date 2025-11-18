variable "public_ip" {
  description = "this variable is for public ip"
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    allocation_method       = string
    sku                     = optional(string)
    sku_tier                = optional(string)
    ip_version              = optional(string)
    domain_name_label       = optional(string)
    idle_timeout_in_minutes = optional(number)
    zones                   = optional(set(string))
    public_ip_prefix_id     = optional(string)
    edge_zone               = optional(string)
    tags                    = optional(map(string))
  }))
}
