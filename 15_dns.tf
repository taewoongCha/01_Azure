resource "azurerm_dns_zone" "team4_dns_zone" {
  name                = "twcc.store"
  resource_group_name = azurerm_resource_group.team4_rg.name
}
resource "azurerm_dns_a_record" "team4_dns_a" {
  name                = "www"
  zone_name           = azurerm_dns_zone.team4_dns_zone.name
  resource_group_name = azurerm_resource_group.team4_rg.name
  ttl                 = 300
  records             = [azurerm_public_ip.team4_pubip_apg.ip_address]
}