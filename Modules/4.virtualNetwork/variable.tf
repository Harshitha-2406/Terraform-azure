
variable "resourceGroupNameShared" {
  description = "RG for network and keyvault"
  type        = string
}
variable "prefix" {}
variable "suffix" {}
variable "location" {}
variable "vnetRange" {}
variable "publicSubnetRange" {}
variable "privateSubnetRange" {}