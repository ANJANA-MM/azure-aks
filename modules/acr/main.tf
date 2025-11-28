resource "azurerm_container_registry" "acr" {
  name                = lower("${replace(var.prefix, "/[^a-z0-9]/", "")}acr")
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
  tags                = var.tags
}

# Separate resource for retention policy
#resource "azurerm_container_registry_retention_policy" "acr" {
 # registry_name       = azurerm_container_registry.acr.name
  #resource_group_name = var.resource_group
  #days                = 30
  #status              = "Enabled"
#}