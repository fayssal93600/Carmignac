terraform {
  backend "azurerm" {
    resource_group_name  = "CGP-DEV-RG-EDM"
    storage_account_name = "cgpdevsaedm01"
    container_name       = "terraform"
    key                  = "tf/terraform.datafactory.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.71.0"
    }
  }
}

provider "azurerm" {
  features {}
}

#PrivateEndpoint
#EDM02, IP: 10.XXX.47.24
module "azure_datafactory_private_endpoint" {
  source                          = "./Modules/AzureDataFactory/PrivateEndpoint"
  name                            = var.azure_data_factory.private_endpoint_name
  resource_group_name             = var.application.resource_group_name
  location                        = var.infra.location
  subnet_id                       = data.azurerm_subnet.subnet_private_endpoint.id
  private_service_connection_name = var.azure_data_factory.private_endpoint_name
  resource_id                     = module.az_data_factory.id
  subresource_name                = "dataFactory"
  tags                            = {
    ProjectName = var.application.tags.ProjectName
    ProjectCode = var.application.tags.ProjectCode
    Environment = var.application.tags.Environment
    Deployment  = var.application.tags.Deployment
    Owner       = var.application.tags.Owner
    BillingTo   = var.application.tags.BillingTo
    Role        = "azure azureDataFactory private endpoint"
  }
  depends_on                      = [module.az_data_factory]
}
#UserAssignedManagedIdentity using existing one
/*module "adf_users_assigned_mi" {
  source = "./Modules/ManagedIdentity"
  name = var.identity.name
  resource_group_name = var.identity.resource_group_name
  location = var.infra.location
  tags = {
    ProjectName = var.application.tags.ProjectName
    ProjectCode = var.application.tags.ProjectCode
    Environment = var.application.tags.Environment
    Deployment  = var.application.tags.Deployment
    Owner       = var.application.tags.Owner
    BillingTo   = var.application.tags.BillingTo
    Role        = "UserAssignedManagedIdentity"
  }
}*/
#AssignmentRole
/*module "adf_users_assigned_mi_role" {
  source = "./Modules/AssignmentRole"
  scope                = var.kv_assignment_role.scope
  role_definition_name = var.kv_assignment_role.role_definition_name
  principal_id         = data.azurerm_user_assigned_identity.adf_identity.principal_id
}*/

#AzureDataFactory
module "az_data_factory" {
  source = "./Modules/AzureDataFactory"
  name = var.azure_data_factory.name
  resource_group_name = var.azure_data_factory.resource_group_name
  public_network_enabled = var.azure_data_factory.public_network_enabled
  location = var.infra.location
  //adf_assigned_mi_name = var.azure_data_factory.managed_identity_name
  identity = {
    type = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.adf_identity.id]
  }
  customer_managed_key_id = var.azure_data_factory.customer_managed_key_id
  //customer_managed_key_identity_id = var.azure_data_factory.customer_managed_key_identity_id

  tags = {
    ProjectName = var.application.tags.ProjectName
    ProjectCode = var.application.tags.ProjectCode
    Environment = var.application.tags.Environment
    Deployment  = var.application.tags.Deployment
    Owner       = var.application.tags.Owner
    BillingTo   = var.application.tags.BillingTo
    Role        = "azureDataFactory"
  }


}