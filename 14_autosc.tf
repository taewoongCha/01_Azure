data "azurerm_shared_image_version" "search2" {
  name                = azurerm_shared_image_version.team4_simgv.name
  image_name          = azurerm_shared_image_version.team4_simgv.image_name
  gallery_name        = azurerm_shared_image_version.team4_simgv.gallery_name
  resource_group_name = azurerm_shared_image_version.team4_simgv.resource_group_name
  depends_on          = [azurerm_shared_image_version.team4_simgv]
}
resource "azurerm_linux_virtual_machine_scale_set" "team4_vmss" {
  name                = "team4-vmss"
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_resource_group.team4_rg.location
  sku                 = "Standard_F1s"
  instances           = 1
  admin_username      = "team4"
  #  user_data=base64encode(file("./999_autoscalescript.sh"))

  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }

  admin_ssh_key {
    username   = "team4"
    public_key = file("./id_rsa.pub")
  }
  source_image_id = data.azurerm_shared_image_version.search2.id
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = 10
  }
  network_interface {
    name                      = "team4-autonic"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.team4_web_nsg.id

    ip_configuration {
      name                                         = "internal"
      primary                                      = true
      subnet_id                                    = azurerm_subnet.team4_web1.id
      application_gateway_backend_address_pool_ids = [tolist(azurerm_application_gateway.team4_apgw.backend_address_pool)[0].id]
    }
  }
}
resource "azurerm_monitor_autoscale_setting" "atscset" {
  name                = "team4-atscset"
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_resource_group.team4_rg.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.team4_vmss.id

  profile {
    name = "team4-profile"

    capacity {
      default = 1
      minimum = 1
      maximum = 6
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.team4_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.team4_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = 2
        cooldown  = "PT1M"
      }
    }
  }
}
