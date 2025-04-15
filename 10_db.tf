resource "azurerm_private_dns_zone" "team4_mysqldns" {
  name                = "team4.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.team4_rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "team4_pridns" {
  name                  = "team4pridns.com"
  private_dns_zone_name = azurerm_private_dns_zone.team4_mysqldns.name
  virtual_network_id    = azurerm_virtual_network.team4_vnet.id
  resource_group_name   = azurerm_resource_group.team4_rg.name
}
resource "azurerm_mysql_flexible_server" "team4_mysql" {
  name                   = "team4-mysql"
  resource_group_name    = azurerm_resource_group.team4_rg.name
  location               = azurerm_resource_group.team4_rg.location
  administrator_login    = "team4"
  administrator_password = "It12345!"
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.team4_db.id
  private_dns_zone_id    = azurerm_private_dns_zone.team4_mysqldns.id
  sku_name               = "B_Standard_B1ms"
  depends_on             = [azurerm_private_dns_zone_virtual_network_link.team4_pridns]
}
resource "azurerm_mysql_flexible_database" "team4_mysqldb" {
  name                = "wordpress"
  resource_group_name = azurerm_resource_group.team4_rg.name
  server_name         = azurerm_mysql_flexible_server.team4_mysql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
resource "azurerm_mysql_flexible_server_configuration" "team4_mysqlconf" {
  name                = "require_secure_transport"
  server_name         = azurerm_mysql_flexible_server.team4_mysql.name
  resource_group_name = azurerm_resource_group.team4_rg.name
  value               = "OFF"
  depends_on          = [azurerm_mysql_flexible_server.team4_mysql]
}
