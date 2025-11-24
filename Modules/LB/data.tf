data "azurerm_public_ip" "pip" {
  for_each            = var.load_balancer
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_network_interface" "nic" {
  for_each            = var.load_balancer
  name                = "Frontend-nic"
  resource_group_name = "TF-RG"
}
