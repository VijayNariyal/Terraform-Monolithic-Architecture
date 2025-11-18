resource "azurerm_storage_account" "stg" {
  for_each                 = var.storage_account
  name                     = lookup(each.value, "storage_account_name", lower(replace(each.key, "/[^a-z0-9]/", "")))
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = lookup(each.value, "account_tier", "Standard")
  account_replication_type = lookup(each.value, "replication_type", "LRS")
  access_tier              = lookup(each.value, "access_tier", null)
  tags                     = each.value.tags == {} ? { environment = "dev" } : each.value.tags

  dynamic "network_rules" {
    for_each = lookup(each.value, "network_rules", []) == [] ? [] : [1]
    content {
      default_action             = lookup(each.value, "network_rules", {})["default_action"]
      virtual_network_subnet_ids = lookup(each.value, "network_rules", {})["virtual_network_subnet_ids"]
      ip_rules                   = lookup(each.value, "network_rules", {})["ip_rules"]
    }
  }
}


resource "azurerm_storage_container" "container" {
  for_each              = var.storage_account
  name                  = each.value.container_name
  storage_account_id    = azurerm_storage_account.stg[each.key].id
  container_access_type = each.value.container_access_type
}

