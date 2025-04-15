
resource "azurerm_virtual_network" "team4_vnet" {
  name                = "team4-vnet"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "team4_bat" {
  name                            = "team4-bat"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  virtual_network_name            = azurerm_virtual_network.team4_vnet.name
  address_prefixes                = ["10.0.0.0/24"]
  default_outbound_access_enabled = true
}
resource "azurerm_subnet" "team4_web1" {
  name                            = "team4-web1"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  virtual_network_name            = azurerm_virtual_network.team4_vnet.name
  address_prefixes                = ["10.0.1.0/24"]
  default_outbound_access_enabled = false
}
resource "azurerm_subnet" "team4_web2" {
  name                            = "team4-web2"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  virtual_network_name            = azurerm_virtual_network.team4_vnet.name
  address_prefixes                = ["10.0.2.0/24"]
  default_outbound_access_enabled = false
}
resource "azurerm_subnet" "team4_nat" {
  name                            = "team4-nat"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  virtual_network_name            = azurerm_virtual_network.team4_vnet.name
  address_prefixes                = ["10.0.3.0/24"]
  default_outbound_access_enabled = true
}
resource "azurerm_subnet" "team4_apg" {
  name                            = "team4-apg"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  virtual_network_name            = azurerm_virtual_network.team4_vnet.name
  address_prefixes                = ["10.0.4.0/24"]
  default_outbound_access_enabled = true
}
resource "azurerm_subnet" "team4_db" {
  name                            = "team4-db"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  virtual_network_name            = azurerm_virtual_network.team4_vnet.name
  address_prefixes                = ["10.0.5.0/24"]
  default_outbound_access_enabled = false
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}
resource "azurerm_subnet" "team4_vpn" {
  name                            = "team4-vpn"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  virtual_network_name            = azurerm_virtual_network.team4_vnet.name
  address_prefixes                = ["10.0.6.0/24"]
  default_outbound_access_enabled = true
}