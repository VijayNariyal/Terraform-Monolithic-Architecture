module "RG" {
  source = "../../Modules/RG"
  rg     = var.rgs
}

module "vnet" {
  depends_on      = [module.RG]
  source          = "../../Modules/VNET"
  virtual_network = var.vnets
}

module "kv" {
  depends_on = [module.RG]
  source     = "../../Modules/KV"
  key_vault  = var.key_vault_parent
}

module "virtual_machine" {
  depends_on = [module.vnet, module.kv]
  source     = "../../Modules/VM"
  vms        = var.vm_nic
}

# module "mssql_server" {
#   depends_on = [module.RG, module.kv]
#   source     = "../../Modules/MSSQL_Server"
#   sqlserver  = var.sqls
# }

# module "mssql_server_database" {
#   depends_on     = [module.mssql_server]
#   source         = "../../Modules/MSSQL_DB"
#   mssql_database = var.mssql_db
# }

module "pip" {
  depends_on = [module.RG]
  source     = "../../Modules/PIP"
  public_ip  = var.pip
}

module "bastion" {
  depends_on   = [module.vnet, module.pip, module.virtual_machine]
  source       = "../../Modules/Bastion"
  bastion_host = var.bastion
}

module "stg_account" {
  depends_on      = [module.RG]
  source          = "../../Modules/STG"
  storage_account = var.stg
}

module "loadbalancer" {
  depends_on    = [module.virtual_machine, module.pip]
  source        = "../../Modules/LB"
  load_balancer = var.lb
}

module "lb-nic-association" {
  depends_on = [module.loadbalancer]
  source     = "../../Modules/LB-NIC-Association"
}