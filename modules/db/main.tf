resource "random_password" "admin" {
  length           = 20
  special          = true
  override_special = "_%@"
}

resource "azurerm_private_dns_zone" "mysql" {
  # You must NOT use the default MS zone "privatelink.mysql.database.azure.com"
  # Azure creates this internally. Use a custom zone prefix.
  name                = "${var.prefix}.privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql_vnet_link" {
  name                  = "${var.prefix}-mysql-dns-link"
  resource_group_name   = var.resource_group
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}

resource "azurerm_mysql_flexible_server" "db" {
  name                   = "${var.prefix}-${var.server_name}"
  location               = var.location
  resource_group_name    = var.resource_group
  administrator_login    = var.admin_username
  administrator_password = random_password.admin.result
  sku_name               = var.sku_name
  version = var.mysql_version

  storage {
    size_gb = var.storage_gb
  }

  #backup_retention_days = 7

  #high_availability {
   # mode = "Disabled"
  #}

  # No high_availability block — HA is disabled by default


  delegated_subnet_id         = var.delegated_subnet_id
  private_dns_zone_id         = azurerm_private_dns_zone.mysql.id
  #public_network_access_enabled = false

  tags = var.tags

  # Prevent password drift when Azure changes metadata internally
  lifecycle {
    ignore_changes = [administrator_password]
  }

  # Ensure DNS link exists before server tries to validate private endpoint
  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.mysql_vnet_link
  ]
}

resource "azurerm_mysql_flexible_database" "app" {
  name                = var.database_name
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_flexible_server.db.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"

  depends_on = [
    azurerm_mysql_flexible_server.db
  ]
}

