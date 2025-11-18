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

module "kv_secret" {
  depends_on = [module.kv]
  source     = "../../Modules/KV_Secret"
  kv_secret  = var.secrets
}


module "virtual_machine" {
  depends_on = [module.vnet, module.kv_secret]
  source     = "../../Modules/VM"
  vms        = var.vm_nic
}

# module "mssql_server" {
#   depends_on = [module.RG, module.kv_secret]
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
  depends_on   = [module.vnet, module.pip]
  source       = "../../Modules/Bastion"
  bastion_host = var.bastion
}

module "stg_account" {
  depends_on      = [module.RG]
  source          = "../../Modules/STG"
  storage_account = var.stg
}
