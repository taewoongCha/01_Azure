resource "null_resource" "Generalize_web1_1" {
  provisioner "local-exec" {
    command = "az vm deallocate --resource-group 02-team4-rg --name team4-web1"
  }
  depends_on = [null_resource.Delay]
}
resource "null_resource" "Generalize_web1_2" {
  provisioner "local-exec" {
    command = "az vm generalize --resource-group 02-team4-rg --name team4-web1"
  }
  depends_on = [null_resource.Generalize_web1_1]
}
resource "null_resource" "Delay" {
  provisioner "local-exec" {
    command = "ping 127.0.0.1 -n 121 > nul"
  }
  depends_on = [azurerm_linux_virtual_machine.team4_web1]
}
