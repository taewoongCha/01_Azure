resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "team4_backpool1" {
  ip_configuration_name   = "team4-web1-nic-conf"
  network_interface_id    = azurerm_network_interface.team4_web1_nic.id
  backend_address_pool_id = tolist(azurerm_application_gateway.team4_apgw.backend_address_pool)[0].id
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "team4_backpool2" {
  ip_configuration_name   = "team4-web2-nic-conf"
  network_interface_id    = azurerm_network_interface.team4_web2_nic.id
  backend_address_pool_id = tolist(azurerm_application_gateway.team4_apgw.backend_address_pool)[0].id
}