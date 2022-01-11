resource "azurerm_public_ip" "bastion_host_publicip" {
  name = "${local.resource_name_prefix}-bastion-linuxvm-publicip"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static" #dynamic
  sku               = "Standard"
  tags              = local.common_tags
}
resource "azurerm_network_interface" "bastion_linuxvm_nic" {
  name = "${local.resource_name_prefix}-bastion-linux-vm-nic"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "bastion-linuxvm-ip-1"
    subnet_id                     = azurerm_subnet.bastionsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_publicip.id
  }
}
resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {
  name = "${local.resource_name_prefix}-bastion-linuxvm"
  #computer_name = "web-linx-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size      = "Standard_DS1_v2"
  admin_username      = "azureuser"
  # admin_password = "Azure@123456789"
  network_interface_ids = [azurerm_network_interface.bastion_linuxvm_nic.id]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
}