variable "location" {
  type    = string
  default = "Central India"
}

variable "rg_name" {
  type    = string
  default = "rg-aks-acr-demo"
}

variable "aks_name" {
  type    = string
  default = "aks-single-node-demo"
}

variable "acr_name" {
  type    = string
  # IMPORTANT: ACR name must be globally unique, 5-50 chars, only lowercase letters & numbers.
  default = "acruniquedemo12345"
}

variable "dns_prefix" {
  type    = string
  default = "aksdemo"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "node_vm_size" {
  type    = string
  default = "Standard_B2s"
}
