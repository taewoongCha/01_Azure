resource "azurerm_shared_image_gallery" "team4_gal" {
  name                = "team4gal"
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_resource_group.team4_rg.location
  description         = "team4's IMG share gallery"
}
resource "azurerm_image" "team4_img" {
  name                      = "team4-img"
  location                  = azurerm_resource_group.team4_rg.location
  resource_group_name       = azurerm_resource_group.team4_rg.name
  source_virtual_machine_id = azurerm_linux_virtual_machine.team4_web1.id
  hyper_v_generation        = "V2"

  os_disk {
    storage_type = "StandardSSD_LRS"
    os_type      = "Linux"
    os_state     = "Specialized"
    caching      = "ReadWrite"
    size_gb      = 10
  }
  depends_on = [null_resource.Generalize_web1_2]
}
resource "azurerm_shared_image" "team4_simg" {
  name                         = "team4-simg"
  gallery_name                 = azurerm_shared_image_gallery.team4_gal.name
  resource_group_name          = azurerm_resource_group.team4_rg.name
  location                     = azurerm_resource_group.team4_rg.location
  os_type                      = "Linux"
  hyper_v_generation           = "V2"
  architecture                 = "x64"
  min_recommended_vcpu_count   = 1
  max_recommended_vcpu_count   = 1
  min_recommended_memory_in_gb = 1
  max_recommended_memory_in_gb = 2
  identifier {
    sku       = "9-base"
    offer     = "rockylinux-x86_64"
    publisher = "resf"
  }
}
data "azurerm_image" "search" {
  name                = "team4-img"
  resource_group_name = "02-team4-rg"
  depends_on          = [azurerm_image.team4_img]
}
resource "azurerm_shared_image_version" "team4_simgv" {
  name                = "1.0.0"
  gallery_name        = azurerm_shared_image_gallery.team4_gal.name
  image_name          = azurerm_shared_image.team4_simg.name
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_resource_group.team4_rg.location

  target_region {
    name                   = azurerm_shared_image.team4_simg.location
    regional_replica_count = 1
    storage_account_type   = "Standard_LRS"
  }
  managed_image_id = data.azurerm_image.search.id
  depends_on       = [azurerm_shared_image.team4_simg]
}
