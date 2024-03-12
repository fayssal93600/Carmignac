terraform_container = {
  name                = "cgpprdstoragetfstate"
  resource_group_name = "CGP-PRD-RG-INF01"
  container_name      = "esg"
  access_type         = "private"
}

infra = {
  region_prefix         = "cgp"
  min_tls               = "TLS1_2"
  location              = "France Central"
  private_endpoint_vnet = {
    prefix_name                  = "CGP-PRD-EDM"
    vnet_name                    = "CGP-PRD-VN120"
    subnet_name_private_endpoint = "CGP-PRD-SN047"
    subnet_name_azure_function   = "CGP-PRD-SN048"
    resource_group_name          = "CGP-PRD-RG-INF01"
    vnetAddressPrefix            =  "10.139"
  }
}

application = {
  name                    = "EDM"
  resource_group_name     = "CGP-PRD-RG-EDM"
  app_resource_group_name = "CGP-PRD-RG-EDM"
  environment             = "PRD"
  log_analytics           = {
    resource_group_name = "CGP-PRD-RG-INF01"
    workspace_name      = "CGP-PRD-LA-INF01"
  }
  tags                    = {
    Owner       = "Technology Infrastructure"
    BillingTo   = "Technology Infrastructure"
    ProjectName = "EDM"
    ProjectCode = "EDM"
    Deployment  = "Terraform"
    Environment = "PRD"
  }
}

identity = {
  resource_group_name = "CGP-PRD-RG-INF01"
  name = "CGP-PRD-MI-EDM01"
  tags                    = {
    Owner       = "Technology Infrastructure"
    BillingTo   = "Technology Infrastructure"
    ProjectName = "EDM"
    ProjectCode = "EDM"
    Deployment  = "Terraform"
    Environment = "PRD"
  }
}

azure_data_factory = {
  name = "CGP-PRD-DF-EDM01"
  resource_group_name = "CGP-PRD-RG-EDM"
  private_endpoint_name = "CGP-PRD-PE-EDM07"
  public_network_enabled = false
  identity = {
    type = "UserAssigned"
    identity_ids = ["/subscriptions/59d0136c-36de-44d6-b737-841c187b72b7/resourcegroups/CGP-PRD-RG-INF01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/CGP-PRD-MI-EDM01"]
  }
  customer_managed_key_id = "https://cgp-prd-kv-edm01.vault.azure.net/keys/EDM-DATAFACTORY-KEY/ebee5d97a592469a9fac6cbf7c2ccf82"
}