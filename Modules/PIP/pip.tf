resource "azurerm_public_ip" "pip" {
  for_each                = var.public_ip
  name                    = each.value.name
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  allocation_method       = each.value.allocation_method
  sku                     = each.value.sku == null ? "Standard" : each.value.sku
  sku_tier                = each.value.sku_tier == null ? "Regional" : each.value.sku_tier
  ip_version              = each.value.ip_version == null ? "IPv4" : each.value.ip_version
  domain_name_label       = each.value.domain_name_label == null ? null : each.value.domain_name_label
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes == null ? 4 : each.value.idle_timeout_in_minutes
  zones                   = each.value.zones == null ? [] : each.value.zones
  public_ip_prefix_id     = each.value.public_ip_prefix_id == null ? null : each.value.public_ip_prefix_id
  edge_zone               = each.value.edge_zone != "" ? each.value.edge_zone : ""
  tags                    = lookup(each.value, "tags", {})
}
