data "azurerm_mssql_server" "mssql" {
  for_each            = var.mssql_database
  name                = each.value.mssql_server_name
  resource_group_name = each.value.resource_group_name
}
