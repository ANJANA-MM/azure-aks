locals {
  name_prefix = "${var.prefix}-${var.environment}"

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      DeployedBy  = "terraform"
    }
  )
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}-rg"
  location = local.location
  tags     = local.common_tags
}

module "network" {
  source         = "./modules/network"
  prefix         = local.name_prefix
  location       = local.location
  resource_group = azurerm_resource_group.rg.name

  # 🚀 Dynamic VNet + Subnets (no hardcoding)
  address_space = [local.vnet_cidr]
  subnets = {
    aks     = { address_prefixes = [local.subnets.aks] }
    db      = { address_prefixes = [local.subnets.db] }
    ingress = { address_prefixes = [local.subnets.ingress] }
  }

  tags = local.common_tags
}

module "acr" {
  source         = "./modules/acr"
  prefix         = local.name_prefix
  location       = local.location
  resource_group = azurerm_resource_group.rg.name
  tags           = local.common_tags
}

module "db" {
  source              = "./modules/db"
  prefix              = local.name_prefix
  location            = local.location
  resource_group      = azurerm_resource_group.rg.name
  vnet_id             = module.network.vnet_id
  delegated_subnet_id = module.network.db_subnet_id

  admin_username      = var.mysql_admin_username
  sku_name            = var.mysql_sku_name
  mysql_version       = var.mysql_version   # ✅ This is fine inside the module block
  storage_gb          = var.mysql_storage_mb / 1024

  database_name       = "appdb"
  server_name         = "${local.name_prefix}-mysql"

  tags = local.common_tags
}


module "aks" {
  source                     = "./modules/aks"
  prefix                     = local.name_prefix
  location                   = local.location
  resource_group             = azurerm_resource_group.rg.name
  subnet_id                  = module.network.aks_subnet_id
  kubernetes_version         = var.kubernetes_version
  aad_admin_group_object_ids = var.aad_admin_group_object_ids
  allowed_ip_ranges          = var.api_server_authorized_ip_ranges
  acr_id                     = module.acr.acr_id
  tags                       = local.common_tags
}
