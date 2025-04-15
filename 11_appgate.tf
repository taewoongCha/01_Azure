resource "azurerm_application_gateway" "team4_apgw" {
  name                = "team4-apgw"
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_resource_group.team4_rg.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "team4-apgw-ipconf"
    subnet_id = azurerm_subnet.team4_apg.id
  }

  frontend_port {
    name = "team4-frontport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "team4-frontconf"
    public_ip_address_id = azurerm_public_ip.team4_pubip_apg.id
  }

  backend_address_pool {
    name         = "team4-backpool"
  }

  backend_http_settings {
    name                  = "team4-httpset"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "team4-li"
    frontend_ip_configuration_name = "team4-frontconf"
    frontend_port_name             = "team4-frontport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "team4-routerule"
    rule_type                  = "Basic"
    http_listener_name         = "team4-li"
    backend_address_pool_name  = "team4-backpool"
    backend_http_settings_name = "team4-httpset"
    priority                   = 1
  }
}