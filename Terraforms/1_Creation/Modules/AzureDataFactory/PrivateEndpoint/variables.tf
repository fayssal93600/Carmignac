variable "resource_group_name" {
  description = "The name of the resource group in wich all resources will be create"
}

variable "location" {
  description = "The location of the resource"
}

variable "name" {
  description = "The name of the resource"
}

variable "subnet_id" {
  description = "The identifier of the subnet"
}

variable "private_service_connection_name" {
  description = "The name of the private service connection"
}

variable "resource_id" {
  description = "The targeted resource identifier"
}

variable "subresource_name" {
  description = "The subresource name"
}

variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module"
}

variable "endpoint_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}