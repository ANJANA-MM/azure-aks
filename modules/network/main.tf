resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.prefix}-snet-aks"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnets["aks"].address_prefixes
}

resource "azurerm_subnet" "db" {
  name                 = "${var.prefix}-snet-db"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnets["db"].address_prefixes

  delegation {
    name = "mysql-flexible-delegation"
    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet" "ingress" {
  name                 = "${var.prefix}-snet-ingress"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnets["ingress"].address_prefixes
}
