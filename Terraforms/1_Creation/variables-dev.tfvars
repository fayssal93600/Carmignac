terraform_container = {
  name                = "cgpdevstoragetfstate"
  resource_group_name = "CGP-DEV-RG-INF01"
  container_name      = "esg"
  access_type         = "private"
}

infra = {
  region_prefix         = "cgp"
  min_tls               = "TLS1_2"
  location              = "France Central"
  private_endpoint_vnet = {
    prefix_name                  = "CGP-DEV-EDM"
    vnet_name                    = "CGP-DEV-VN100"
    subnet_name_private_endpoint = "CGP-DEV-SN047"
    subnet_name_azure_function   = "CGP-DEV-SN048"
    resource_group_name          = "CGP-DEV-RG-INF01"
    vnetAddressPrefix            =  "10.139"
  }
}

application = {
  name                    = "EDM"
  resource_group_name     = "CGP-DEV-RG-EDM"
  app_resource_group_name = "CGP-DEV-RG-EDM"
  environment             = "dev"
  log_analytics           = {
    resource_group_name = "CGP-DEV-RG-INF01"
    workspace_name      = "CGP-DEV-LA-INF01"
  }
  tags                    = {
    Owner       = "Technology Infrastructure"
    BillingTo   = "Technology Infrastructure"
    ProjectName = "EDM"
    ProjectCode = "EDM"
    Deployment  = "Terraform"
    Environment = "DEV"
  }
}

identity = {
  resource_group_name = "CGP-DEV-RG-INF01"
  name = "CGP-DEV-MI-EDM01"
  tags                    = {
    Owner       = "Technology Infrastructure"
    BillingTo   = "Technology Infrastructure"
    ProjectName = "EDM"
    ProjectCode = "EDM"
    Deployment  = "Terraform"
    Environment = "DEV"
  }
}

azure_data_factory = {
  name = "CGP-DEV-DF-EDM01"
  resource_group_name = "CGP-DEV-RG-EDM"
  private_endpoint_name = "CGP-DEV-PE-EDM02"
  public_network_enabled = false
  identity = {
    type = "UserAssigned"
    identity_ids = ["/subscriptions/87b720b3-fcb9-4bd5-8047-816efd16c823/resourceGroups/CGP-DEV-RG-INF01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/CGP-DEV-MI-EDM01"]
  }
  customer_managed_key_id = "https://cgp-dev-kv-edm01.vault.azure.net/keys/EDM-DATAFACTORY-KEY/432edaa0d38647c0a55fa215e506d4b8"
}

