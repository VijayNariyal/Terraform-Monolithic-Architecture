variable "vms" {
  description = "this is for nic and vm code variable"
  type = map(object({
    nic_name = string
    location = string
    ip_configurations = map(object({
      ip_configuration_name         = string
      private_ip_address_allocation = string
    }))
    subnet_name                     = string
    virtual_network_name            = string
    resource_group_name             = string
    # pip_name                        = optional(string)
    vm_name                         = string
    size                            = string
    disable_password_authentication = bool
    publisher                       = string
    offer                           = string
    sku                             = string
    version                         = string
    kv_name                         = string
    secret_name_username            = string
    secret_name_password            = string
    nsg_name                        = string
    custom_script_file              = optional(string)
  }))
}
