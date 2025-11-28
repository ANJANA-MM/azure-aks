resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "${var.prefix}-aks"

  kubernetes_version = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  #azure_active_directory {
   # admin_group_object_ids = var.aad_admin_group_object_ids
    #azure_rbac_enabled     = true
  #}

  azure_active_directory_role_based_access_control {
  admin_group_object_ids = var.aad_admin_group_object_ids
  azure_rbac_enabled     = true
}


  role_based_access_control_enabled = true

  #default_node_pool {
   # name       = "system"
    #vm_size    = "Standard_D4s_v5"
    #vnet_subnet_id = var.subnet_id

    #enable_auto_scaling = true
    #min_count = 2
    #max_count = 5

    #orchestrator_version = var.kubernetes_version
    #type                 = "VirtualMachineScaleSets"
    #os_disk_size_gb      = 60
  #}

  #default_node_pool {
  #name                = "system"
  #vm_size             = "Standard_D4s_v5"
  #vnet_subnet_id      = var.subnet_id
  #node_count          = 2   # set your desired number of nodes
  #orchestrator_version = var.kubernetes_version
  #type                 = "VirtualMachineScaleSets"
  #os_disk_size_gb      = 60
#}

# Note: Auto-scaling is not enabled for the default node pool.
  # If you need auto-scaling, create a separate user node pool with enable_auto_scaling = true.

  default_node_pool {
  name                = "system"
  vm_size             = "Standard_D4s_v5"
  vnet_subnet_id      = var.subnet_id
  orchestrator_version = var.kubernetes_version
  type                = "VirtualMachineScaleSets"
  os_disk_size_gb     = 60
  node_count          = 2  # <-- number of VMs in this pool

  #resource "azurerm_kubernetes_cluster_node_pool" "user_pool" {
  #name                  = "userpool"
  #kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  #vm_size               = "Standard_D4s_v5"
  #node_count            = 2
  #enable_auto_scaling    = true
  #min_count             = 2
  #max_count             = 5
  #mode                  = "User"
}


  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  api_server_access_profile {
    authorized_ip_ranges = var.allowed_ip_ranges
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  tags = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
      default_node_pool[0].upgrade_settings
    ]
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
