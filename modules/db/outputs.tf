output "admin_username" {
  value       = var.admin_username
  description = "MySQL admin username"
}

output "admin_password" {
  value       = random_password.admin.result
  description = "MySQL admin password"
  sensitive   = true
}

output "fqdn" {
  value       = azurerm_mysql_flexible_server.db.fqdn
  description = "MySQL server FQDN"
}

output "database_name" {
  value       = var.database_name
  description = "Application database name"
}

output "connection_string" {
  value       = "mysql://${var.admin_username}:${random_password.admin.result}@${azurerm_mysql_flexible_server.db.fqdn}:3306/${var.database_name}"
  sensitive   = true
  description = "Connection string"
}