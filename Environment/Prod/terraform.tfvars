rgs = {
  rg1 = {
    name     = "TF-Prod-RG"
    location = "central india"
    # managed_by = "vijay"
  }
}

vnets = {
  vnet1 = {
    virtual_network_name = "TF-Prod-Vnet"
    location             = "central india"
    resource_group_name  = "TF-Prod-RG"
    # address_space        = ["10.0.0.0/16"]

    subnets = {
      sub1 = {
        subnet_name      = "Frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      sub2 = {
        subnet_name      = "Backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
      sub3 = {
        subnet_name      = "AzureBastionSubnet"
        address_prefixes = ["10.0.3.0/24"]
      }
    }
  }
}

pip = {
  # pip1 = {
  #   name                = "Frontend-pip"
  #   resource_group_name = "TF-Prod-RG"
  #   location            = "central india"
  #   allocation_method   = "Static"
  # }
  # pip2 = {
  #   name                = "Backend-pip"
  #   resource_group_name = "TF-Prod-RG"
  #   location            = "central india"
  #   allocation_method   = "Static"
  # }
  pip3 = {
    name                = "Prod-Bastion-pip"
    resource_group_name = "TF-Prod-RG"
    location            = "central india"
    allocation_method   = "Static"
  }
    pip4 = {
    name                = "Prod-LB-pip"
    resource_group_name = "TF-Prod-RG"
    location            = "central india"
    allocation_method   = "Static"
  }
}

vm_nic = {
  vm_nic1 = {
    nic_name = "Frontend-nic"
    location = "central india"
    ip_configurations = {
      ip_configurations = {
        ip_configuration_name         = "internal"
        private_ip_address_allocation = "Dynamic"
    } }
    subnet_name          = "Frontend-subnet"
    virtual_network_name = "TF-Prod-Vnet"
    resource_group_name  = "TF-Prod-RG"
    # pip_name                        = "Frontend-pip"
    vm_name                         = "Prod-Frontend-VM"
    size                            = "Standard_F2"
    disable_password_authentication = false
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    kv_name                         = "Key-Vault-Name"
    secret_name_username            = "username"
    secret_name_password            = "password"
    nsg_name                        = "Frontend-nsg"
  }
  vm_nic2 = {
    nic_name = "Backend-nic"
    location = "central india"
    ip_configurations = {
      ip_configurations = {
        ip_configuration_name         = "internal"
        private_ip_address_allocation = "Dynamic"
    } }
    subnet_name          = "Backend-subnet"
    virtual_network_name = "TF-Prod-Vnet"
    resource_group_name  = "TF-Prod-RG"
    # pip_name                        = "Backend-pip"
    vm_name                         = "Prod-Backend-VM"
    size                            = "Standard_F2"
    disable_password_authentication = false
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    kv_name                         = "Key-Vault-Name"
    secret_name_username            = "username"
    secret_name_password            = "password"
    nsg_name                        = "Backend-nsg"
  }
}

key_vault_parent = {
  "kv1" = {
    keyvault_name       = "Key-Vault-Name"
    location            = "central india"
    resource_group_name = "TF-Prod-RG"
    sku_name            = "standard"
    access_policy = [{
      key_permissions     = ["Get", ]
      secret_permissions  = ["Get", "Set", "List", "Delete", "Purge", "Recover"]
      storage_permissions = ["Get", ]
    }]
    username_secret = {
      name  = "username"
      value = "VM-USERNAME"
    }
    password_secret = {
      name  = "password"
      value = "VM-PASSWORD"
    }
  }
}

sqls = {
  "sql1" = {
    sql_server_name      = "MSSQL-NAME"
    resource_group_name  = "TF-Prod-RG"
    location             = "central india"
    version              = "12.0"
    kv_name              = "Key-Vault-Name"
    secret_name_username = "username"
    secret_name_password = "password"
  }
}

mssql_db = {
  "db1" = {
    mssql_database_name = "my_db"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    mssql_server_name   = "MSSQL-NAME"
    resource_group_name = "TF-Prod-RG"
  }
}


bastion = {
  bastion1 = {
    bastion_name         = "Prod_vm_bastion"
    location             = "central india"
    resource_group_name  = "TF-Prod-RG"
    subnet_name          = "AzureBastionSubnet"
    virtual_network_name = "TF-Prod-Vnet"
    pip_name             = "Prod-Bastion-pip"
    ip_configuration = {
      conf1 = {
        ip_configuration_name = "configuration"
      }
    }
  }
}

stg = {
  stg1 = {
    storage_account_name  = "STORAGE-NAME"
    resource_group_name   = "TF-Prod-RG"
    location              = "central india"
    account_tier          = "Standard"
    container_name        = "stg-container"
    container_access_type = "blob"
  }
}

lb = {
  "lb1" = {
    lb_name             = "Prod-TF-LB"
    location            = "central india"
    resource_group_name = "TF-Prod-RG"
    pip_name            = "Prod-LB-pip"
    frontend_ip_configuration = [{
      frontend_name = "PublicIPAddress"
    }]
    lbbackend_name = "backendpool"
    lbrule_name    = "HttpAllow"
    protocol       = "Tcp"
    frontend_port  = 8080
    backend_port   = 80
    lb_outbound_rule = "OutboundRule"
  }
}
