terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstateaccountdemo"   # must be globally unique
    container_name       = "tfstate"
    key                  = "aks-acr/terraform.tfstate"
  }
}
