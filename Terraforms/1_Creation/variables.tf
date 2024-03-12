# ======================================================================================
# Common
# ======================================================================================
variable "terraform_container" {
  type = object({
    resource_group_name   = string
    //storage_account_name  = string
    container_name        = string
    //key                   = string
    access_type           = string
  })
}

variable "infra" {
  type = object({
    region_prefix         = string
    min_tls               = string
    location              = string
    private_endpoint_vnet = object({
      prefix_name                  = string
      vnet_name                    = string
      subnet_name_private_endpoint = string
      subnet_name_azure_function   = string
      resource_group_name          = string
      vnetAddressPrefix            = string
    })
  })
}

/*variable "kv_assignment_role" {
  type = object({
    scope                           = string
    principal_id                           = string
    role_definition_name                   = string
  })
}*/

variable "identity" {
  type = object({
    name                           = string
    resource_group_name            = string
  })
}

variable "azure_data_factory" {
  type = object({
    name                           = string
    resource_group_name            = string
    public_network_enabled = bool
    private_endpoint_name           = string
    identity = object({
      type           = string
      identity_ids           = list(string)
    })
    customer_managed_key_id           = string
    //customer_managed_key_identity_id          = string
  })
}

variable "application" {
  type = object({
    name                    = string
    resource_group_name     = string
    tags                    = object({
      Owner       = string
      BillingTo   = string
      ProjectName = string
      ProjectCode = string
      Deployment  = string
      Environment = string
    })
  })
}
