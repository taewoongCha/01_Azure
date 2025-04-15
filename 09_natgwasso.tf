resource "azurerm_subnet_nat_gateway_association" "team4_natgwasso_1" {
  subnet_id      = azurerm_subnet.team4_web1.id
  nat_gateway_id = azurerm_nat_gateway.team4_nat.id
}
resource "azurerm_subnet_nat_gateway_association" "team4_natgwasso_2" {
  subnet_id      = azurerm_subnet.team4_web2.id
  nat_gateway_id = azurerm_nat_gateway.team4_nat.id
}
