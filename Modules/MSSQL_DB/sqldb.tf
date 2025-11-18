resource "azurerm_mssql_database" "mssql_db" {
  for_each     = var.mssql_database
  name         = each.value.mssql_database_name
  server_id    = data.azurerm_mssql_server.mssql[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = lookup(each.value, "max_size_gb", 2)
  sku_name     = lookup(each.value, "sku_name", "50")
  enclave_type = lookup(each.value, "enclave_type", "VBS")
  tags         = lookup(each.value, "tags", { foo = "bar" })
}
