output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of the VNet"
}

output "aks_subnet_id" {
  value       = azurerm_subnet.aks.id
  description = "ID of the AKS subnet"
}

output "db_subnet_id" {
  value       = azurerm_subnet.db.id
  description = "ID of the DB subnet"
}
