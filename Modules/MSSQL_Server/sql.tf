resource "azurerm_mssql_server" "sqlserver" {
  for_each                     = var.sqlserver
  name                         = each.value.sql_server_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.kv_secret_username[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.kv_secret_password[each.key].value
  tags                         = each.value.tags == {} ? { environment = "testing" } : each.value.tags
}
