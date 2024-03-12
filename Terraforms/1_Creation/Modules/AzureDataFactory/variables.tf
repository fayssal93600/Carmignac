variable "resource_group_name" {
  description = "The name of the resource group in wich all resources will be create"
}

variable "public_network_enabled"{
  description = "Is the Data Factory visible to the public network"
}

variable "location" {
  description = "The location of the resource"
}

variable "identity" {
  description = "Optional. Identifier of the identity for this resource."
  default     = ""
}

variable "name" {
  description = "The name of the resource"
}

/*variable "adf_assigned_mi_name" {
  description = "The name of the resource"
}*/

variable "customer_managed_key_id" {
  description = "Specifies the Azure Key Vault Key ID to be used as the Customer Managed Key (CMK) for double encryption. Required with user assigned identity"
}

/*variable "customer_managed_key_identity_id" {
  description = ""
}*/

variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module"
}