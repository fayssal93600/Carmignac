## ======================================================================================
## Data source references (must exist before running this script)
## ======================================================================================
data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet_private_endpoint" {
  name                 = var.infra.private_endpoint_vnet.subnet_name_private_endpoint
  virtual_network_name = var.infra.private_endpoint_vnet.vnet_name
  resource_group_name  = var.infra.private_endpoint_vnet.resource_group_name
}

data "azurerm_user_assigned_identity" "adf_identity" {
  name                = var.identity.name
  resource_group_name = var.identity.resource_group_name
  //depends_on = [module.adf_users_assigned_mi]
}