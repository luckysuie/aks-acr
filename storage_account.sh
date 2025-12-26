#!/usr/bin/env bash
set -euo pipefail

LOCATION="Central India"
TFSTATE_RG="rg-terraform-state"
TFSTATE_SA="tfstateaccountdemo"
TFSTATE_CONTAINER="tfstate"

az account show 1>/dev/null

az group create --name "$TFSTATE_RG" --location "$LOCATION"

az storage account create \
  --name "$TFSTATE_SA" \
  --resource-group "$TFSTATE_RG" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2

az storage container create \
  --name "$TFSTATE_CONTAINER" \
  --account-name "$TFSTATE_SA" \
  --auth-mode login
