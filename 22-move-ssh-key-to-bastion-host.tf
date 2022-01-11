#create null provisioner
resource "null_resource" "name" {
  depends_on = [
    azurerm_linux_virtual_machine.bastion_host_linuxvm
  ]
  #first it will make a connection
  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user        = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("~/.ssh/id_rsa.pub")
  }
  #file provionser
  provisioner "file" {
    source     = "~/.ssh/id_rsa.pub"
    destination = "/tmp/id_rsa.pem"
#remote exec
  }
  provisioner "remote-exec" {
      inline = [
        "sudo chmod 400 /tmp/id_rsa.pem"
      ]
  }
}