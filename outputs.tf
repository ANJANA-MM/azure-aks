output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Resource group name for this environment"
}

output "vnet_id" {
  value       = module.network.vnet_id
  description = "ID of the VNet"
}

output "aks_name" {
  value       = module.aks.aks_name
  description = "AKS cluster name"
}

output "acr_login_server" {
  value       = module.acr.login_server
  description = "ACR login server"
}

output "mysql_admin_username" {
  value       = module.db.admin_username
  description = "MySQL admin username"
}

output "mysql_admin_password" {
  value       = module.db.admin_password
  description = "MySQL admin password"
  sensitive   = true
}

output "mysql_fqdn" {
  value       = module.db.fqdn
  description = "MySQL server FQDN"
}
