resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"

  admin_enabled = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "systemnp"
    node_count = var.node_count
    vm_size    = var.node_vm_size
    # For tiny/demo clusters you can reduce cost by enabling auto-scaling later if needed.
  }

  identity {
    type = "SystemAssigned"
  }

  # Optional but common: keeps cluster working with standard policy defaults
  network_profile {
    network_plugin = "azure"
  }
}

# Grant AKS (its kubelet identity) permission to pull images from ACR
# NOTE: For AKS with managed identity, kubelet_identity is the one that pulls images.
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
