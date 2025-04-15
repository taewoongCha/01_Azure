resource "azurerm_linux_virtual_machine" "team4_bat" {
  name                            = "team4-bat"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  location                        = azurerm_resource_group.team4_rg.location
  size                            = "Standard_F1s"
  admin_username                  = "team4"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "team4"
    public_key = file("./id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.team4_bat_nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "9.3.20231113"
  }
  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }
  user_data = base64encode(file("999_batscript.sh"))
}
resource "azurerm_linux_virtual_machine" "team4_web1" {
  name                            = "team4-web1"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  location                        = azurerm_resource_group.team4_rg.location
  size                            = "Standard_F1s"
  admin_username                  = "team4"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "team4"
    public_key = file("./id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.team4_web1_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "9.3.20231113"
  }
  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }
  user_data  = base64encode(file("999_web1script.sh"))
  depends_on = [azurerm_subnet_nat_gateway_association.team4_natgwasso_1]
}
resource "azurerm_linux_virtual_machine" "team4_web2" {
  name                            = "team4-web2"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  location                        = azurerm_resource_group.team4_rg.location
  size                            = "Standard_F1s"
  admin_username                  = "team4"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "team4"
    public_key = file("./id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.team4_web2_nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "9.3.20231113"
  }
  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }
  user_data  = base64encode(file("./999_web2script.sh"))
  depends_on = [null_resource.Generalize_web1_2]
}
resource "azurerm_linux_virtual_machine" "team4_web3" {
  name                            = "team4-web3"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  location                        = azurerm_resource_group.team4_rg.location
  size                            = "Standard_F1s"
  admin_username                  = "team4"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "team4"
    public_key = file("./id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.team4_web1_nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "9.3.20231113"
  }
  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }
  user_data  = base64encode(file("./999_web1script.sh"))
  depends_on = [null_resource.Generalize_web1_2]
}
/*resource "null_resource" "Generalize_web1" {
  provisioner "local-exec" {
    command = "powershell -Command \"Start-Sleep -Seconds 10; \""
  }
    provisioner "local-exec" {
    command = "powershell -Command \"az vm deallocate --resource-group 02-team4-rg --name team4-web1;\""
  }
    provisioner "local-exec" {
    command = "powershell -Command \"Start-Sleep -Seconds 20;\""
  }
    provisioner "local-exec" {
    command = "powershell -Command \"az vm generalize --resource-group 02-team4-rg --name team4-web1\""
  }
  depends_on = [azurerm_linux_virtual_machine.team4_web1]
}*/
