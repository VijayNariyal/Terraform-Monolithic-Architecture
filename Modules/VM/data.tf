data "azurerm_subnet" "subnet" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

# data "azurerm_public_ip" "pip" {
#   for_each            = var.vms
#   name                = lookup(each.value, "pip_name", "")
#   resource_group_name = each.value.resource_group_name
# }

data "azurerm_key_vault" "kv" {
  for_each            = var.vms
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "kv_secret_username" {
  for_each     = var.vms
  name         = each.value.secret_name_username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_key_vault_secret" "kv_secret_password" {
  for_each     = var.vms
  name         = each.value.secret_name_password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
