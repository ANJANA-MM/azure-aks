locals {
  # Supported environments and their subscription IDs
  subscription_ids = {
    dev   = "00000000-0000-0000-0000-000000000001"
    stage = "00000000-0000-0000-0000-000000000002"
    prod  = "00000000-0000-0000-0000-000000000003"
  }

  # Supported environments and their regions
  azure_regions = {
    dev   = "southeastasia"
    stage = "southeastasia"
    prod  = "southeastasia"
  }

  # Supported environments and VNet blocks
  vnet_cidrs = {
    dev   = "10.10.0.0/16"
    stage = "10.20.0.0/16"
    prod  = "10.30.0.0/16"
  }

  # Auto values selected based on current workspace/environment
  subscription_id = lookup(local.subscription_ids, var.environment)
  location        = lookup(local.azure_regions, var.environment)
  vnet_cidr       = lookup(local.vnet_cidrs, var.environment)

  # Auto calculate subnets
  subnets = {
    aks     = cidrsubnet(local.vnet_cidr, 8, 1)
    db      = cidrsubnet(local.vnet_cidr, 8, 2)
    ingress = cidrsubnet(local.vnet_cidr, 8, 3)
  }
}
