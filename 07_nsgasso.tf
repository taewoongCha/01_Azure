resource "azurerm_subnet_network_security_group_association" "team4_nsgasso_bat" {
  subnet_id                 = azurerm_subnet.team4_bat.id
  network_security_group_id = azurerm_network_security_group.team4_bat_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "team4_nsgasso_web1" {
  subnet_id                 = azurerm_subnet.team4_web1.id
  network_security_group_id = azurerm_network_security_group.team4_web_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "team4_nsgasso_web2" {
  subnet_id                 = azurerm_subnet.team4_web2.id
  network_security_group_id = azurerm_network_security_group.team4_web_nsg.id
}

resource "azurerm_network_interface_security_group_association" "team4_nsgasso_batnic" {
  network_interface_id = azurerm_network_interface.team4_bat_nic.id
  network_security_group_id = azurerm_network_security_group.team4_bat_nsg.id
}
resource "azurerm_network_interface_security_group_association" "team4_nsgasso_web1nic" {
  network_interface_id = azurerm_network_interface.team4_web1_nic.id
  network_security_group_id = azurerm_network_security_group.team4_web_nsg.id
}
resource "azurerm_network_interface_security_group_association" "team4_nsgasso_web2nic" {
  network_interface_id = azurerm_network_interface.team4_web2_nic.id
  network_security_group_id = azurerm_network_security_group.team4_web_nsg.id
}