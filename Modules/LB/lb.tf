resource "azurerm_lb" "loadbalancer" {
  for_each            = var.load_balancer
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configuration
    content {
      name                 = frontend_ip_configuration.value.frontend_name
      public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
    }
  }
}

resource "azurerm_lb_backend_address_pool" "lbbackend" {
  for_each        = var.load_balancer
  loadbalancer_id = azurerm_lb.loadbalancer[each.key].id
  name            = each.value.lbbackend_name
}

resource "azurerm_lb_probe" "lbprobe" {
  for_each        = var.load_balancer
  loadbalancer_id = azurerm_lb.loadbalancer[each.key].id
  name            = "Http-running-probe"
  port            = 80
}

resource "azurerm_lb_rule" "lbrule" {
  for_each                       = var.load_balancer
  loadbalancer_id                = azurerm_lb.loadbalancer[each.key].id
  name                           = each.value.lbrule_name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = "PublicIPAddress"
  disable_outbound_snat          = true
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lbbackend[each.key].id]
  probe_id                       = azurerm_lb_probe.lbprobe[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "association" {
  for_each                = var.load_balancer
  network_interface_id    = data.azurerm_network_interface.nic[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbbackend[each.key].id
}

resource "azurerm_lb_outbound_rule" "outbound" {
  for_each                = var.load_balancer
  name                    = each.value.lb_outbound_rule
  loadbalancer_id         = azurerm_lb.loadbalancer[each.key].id
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbbackend[each.key].id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}
