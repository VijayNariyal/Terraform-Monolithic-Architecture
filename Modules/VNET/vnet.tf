resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_network
  name                = each.value.virtual_network_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = try(each.value.address_space, ["10.0.0.0/16"])
  dns_servers         = try(each.value.dns_servers, ["8.8.8.8"])
  dynamic "subnet" {
    for_each = each.value.subnets != "" ? each.value.subnets : {}
    content {
      name             = subnet.value.subnet_name
      address_prefixes = subnet.value.address_prefixes
    }
  }

}
