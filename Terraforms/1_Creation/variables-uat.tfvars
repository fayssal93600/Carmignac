terraform_container = {
  name                = "cgpuatstoragetfstate"
  resource_group_name = "CGP-UAT-RG-INF01"
  container_name      = "esg"
  access_type         = "private"
}

infra = {
  region_prefix         = "cgp"
  min_tls               = "TLS1_2"
  location              = "France Central"
  private_endpoint_vnet = {
    prefix_name                  = "CGP-UAT-EDM"
    vnet_name                    = "CGP-UAT-VN110"
    subnet_name_private_endpoint = "CGP-UAT-SN047"
    subnet_name_azure_function   = "CGP-UAT-SN048"
    resource_group_name          = "CGP-UAT-RG-INF01"
    vnetAddressPrefix            =  "10.139"
  }
}

application = {
  name                    = "EDM"
  resource_group_name     = "CGP-UAT-RG-EDM"
  app_resource_group_name = "CGP-UAT-RG-EDM"
  environment             = "UAT"
  log_analytics           = {
    resource_group_name = "CGP-UAT-RG-INF01"
    workspace_name      = "CGP-UAT-LA-INF01"
  }
  tags                    = {
    Owner       = "Technology Infrastructure"
    BillingTo   = "Technology Infrastructure"
    ProjectName = "EDM"
    ProjectCode = "EDM"
    Deployment  = "Terraform"
    Environment = "UAT"
  }
}

identity = {
  resource_group_name = "CGP-UAT-RG-INF01"
  name = "CGP-UAT-MI-EDM01"
  tags                    = {
    Owner       = "Technology Infrastructure"
    BillingTo   = "Technology Infrastructure"
    ProjectName = "EDM"
    ProjectCode = "EDM"
    Deployment  = "Terraform"
    Environment = "UAT"
  }
}

azure_data_factory = {
  name = "CGP-UAT-DF-EDM01"
  resource_group_name = "CGP-UAT-RG-EDM"
  private_endpoint_name = "CGP-UAT-PE-EDM07"
  public_network_enabled = false
  identity = {
    type = "UserAssigned"
    identity_ids = ["/subscriptions/03c795e0-8a46-47eb-ba0b-10c661d9469f/resourcegroups/CGP-UAT-RG-INF01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/CGP-UAT-MI-EDM01"]
  }
  customer_managed_key_id = "https://cgp-uat-kv-edm01.vault.azure.net/keys/EDM-DATAFACTORY-KEY/ebd1c6a34d5943eca5a0263c57b50500"
}