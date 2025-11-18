data "azurerm_key_vault" "kv" {
  for_each            = var.sqlserver
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "kv_secret_username" {
  for_each     = var.sqlserver
  name         = each.value.secret_name_username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_key_vault_secret" "kv_secret_password" {
  for_each     = var.sqlserver
  name         = each.value.secret_name_password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
