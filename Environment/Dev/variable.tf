variable "rgs" {
  description = "Parent module for rg"
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

variable "vnets" {
  description = "this is for virtual network variable"
  type = map(object({
    virtual_network_name = string
    location             = string
    resource_group_name  = string
    address_space        = optional(list(string))
    dns_servers          = optional(list(string))
    subnets = optional(map(object({
      subnet_name      = string
      address_prefixes = list(string)
    })), {})
  }))
}


variable "pip" {
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

variable "vm_nic" {
  description = "variable for vm and nic"
  type = map(object({
    nic_name = string
    location = string
    ip_configurations = map(object({
      ip_configuration_name         = string
      private_ip_address_allocation = string
    }))
    subnet_name          = string
    virtual_network_name = string
    resource_group_name  = string
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
  }))
}

variable "key_vault_parent" {
  description = "key vault variable from parent folder"
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

variable "sqls" {
  description = "variable for sql server"
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

variable "mssql_db" {
  description = "Variable for mssql server database"
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

variable "bastion" {
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

variable "stg" {
  description = "variable for storage account to store the state file"
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

variable "lb" {
  description = "this is load balancer variable file"
  type = map(object({
    lb_name             = string
    location            = string
    resource_group_name = string
    pip_name            = string
    frontend_ip_configuration = list(object({
      frontend_name = string
    }))
    lbbackend_name = string
    lbrule_name    = string
    protocol       = string
    frontend_port  = number
    backend_port   = number
  }))
}
