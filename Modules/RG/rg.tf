resource "azurerm_resource_group" "RG" {
  for_each   = var.rg
  name       = each.value.name
  location   = each.value.location
  managed_by = each.value.managed_by != null ? each.value.managed_by : "terraform"
  tags = each.value.tags != {} ? each.value.tags : {
    environment = "dev"
  }
}
