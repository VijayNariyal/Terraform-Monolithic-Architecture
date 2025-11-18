variable "bastion_host" {
  description = "this is variable block for azure bastion"
  type = map(object({
    bastion_name         = string
    location             = string
    resource_group_name  = string
    subnet_name          = string
    virtual_network_name = string
    pip_name             = string
    ip_configuration = map(
      object({
        ip_configuration_name = string
      })
    )
  }))
}
