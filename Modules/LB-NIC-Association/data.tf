data "azurerm_lb" "loadbalancer" {
  name                = "TF-LB"
  resource_group_name = "TF-RG"
}

data "azurerm_lb_backend_address_pool" "lbbackend" {
  name            = "backend pool"
  loadbalancer_id = data.azurerm_lb.loadbalancer.id
}

data "azurerm_network_interface" "nic" {
  name                = "Frontend-nic"
  resource_group_name = "TF-RG"
}