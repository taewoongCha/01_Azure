resource "azurerm_network_interface" "team4_bat_nic" {
  name                = "team4-bat-nic"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name

  ip_configuration {
    name                          = "team4-bat-nic-conf"
    subnet_id                     = azurerm_subnet.team4_bat.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.team4_pubip_bat.id
  }
}
resource "azurerm_network_interface" "team4_web1_nic" {
  name                = "team4-web1-nic"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name
  ip_configuration {
    name                          = "team4-web1-nic-conf"
    subnet_id                     = azurerm_subnet.team4_web1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "team4_web2_nic" {
  name                = "team4-web2-nic"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name

  ip_configuration {
    name                          = "team4-web2-nic-conf"
    subnet_id                     = azurerm_subnet.team4_web2.id
    private_ip_address_allocation = "Dynamic"
  }
}