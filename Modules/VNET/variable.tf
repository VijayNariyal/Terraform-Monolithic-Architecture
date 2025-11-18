variable "virtual_network" {
  description = "this is for virtual network variable"
  type = map(object({
    virtual_network_name = string
    location             = string
    resource_group_name  = string
    address_space        = optional(list(string),["10.0.0.0/16"])
    dns_servers           = optional(list(string))
    subnets = optional(map(object({
      subnet_name      = string
      address_prefixes = list(string)
    })),{})
  }))
}
