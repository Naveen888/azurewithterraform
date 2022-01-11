resource "azurerm_subnet" "appsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_adress
}

#we will create a nsg 
resource "azurerm_network_security_group" "app_subnet_nsg" {
  name                = "${azurerm_subnet.appsubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

#assocaite the nsg witha  subnet
resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_association" {
  depends_on = [
    azurerm_network_security_rule.app_nsg_rule_inbound
  ]
  subnet_id                 = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id
}
#local block for security rule
locals {
  app_inbound_ports_maps = {
    #in local if your key start with string or character the value you need to define using =
    #in local if your key start with number the value sjhoul;d be in :
    "110" : "443",
    "120" : "22",
    "130" : "8080"
  }
}


#we will create a nsg rule 
resource "azurerm_network_security_rule" "app_nsg_rule_inbound" {
  for_each                    = local.app_inbound_ports_maps
  name                        = "Rule-Port${each.value}" #Rule-Port-443
  priority                    = each.key                 #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.app_subnet_nsg.name
}

