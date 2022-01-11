output "virtual_network_name" {
  description = "Virtual_network_name"
  value       = azurerm_virtual_network.vnet.name
}
output "virtual_network_id" {
  description = "Virtual_network_id"
  value       = azurerm_virtual_network.vnet.id
}
output "web_subnet_name" {
  value = azurerm_subnet.websubnet.name
}