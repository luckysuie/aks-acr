#!/usr/bin/env bash
set -euo pipefail

# ---- CONFIG (edit if needed) ----
LOCATION="Central India"
TFSTATE_RG="rg-terraform-state"
TFSTATE_SA="tfstateaccountdemo"     # must be globally unique (lowercase + numbers only)
TFSTATE_CONTAINER="tfstate"
# ---------------------------------

echo "Creating/Updating resource group..."
az group create --name "$TFSTATE_RG" --location "$LOCATION"

echo "Creating/Updating storage account..."
az storage account create \
  --name "$TFSTATE_SA" \
  --resource-group "$TFSTATE_RG" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2

echo "Fetching storage account key..."
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group "$TFSTATE_RG" \
  --account-name "$TFSTATE_SA" \
  --query "[0].value" -o tsv)

echo "Creating/Updating blob container..."
az storage container create \
  --name "$TFSTATE_CONTAINER" \
  --account-name "$TFSTATE_SA" \
  --account-key "$ACCOUNT_KEY"

echo "Backend storage ready:"
echo "   RG:        $TFSTATE_RG"
echo "   SA:        $TFSTATE_SA"
echo "   Container: $TFSTATE_CONTAINER"
