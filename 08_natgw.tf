resource "azurerm_nat_gateway" "team4_nat" {
  name                    = "team4-nat"
  location                = azurerm_resource_group.team4_rg.location
  resource_group_name     = azurerm_resource_group.team4_rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}
resource "azurerm_nat_gateway_public_ip_association" "team4_natip" {
  nat_gateway_id = azurerm_nat_gateway.team4_nat.id
  public_ip_address_id = azurerm_public_ip.team4_pubip_nat.id
}