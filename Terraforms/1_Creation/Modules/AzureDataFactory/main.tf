
resource "azurerm_data_factory" "az_data_factory" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  public_network_enabled = var.public_network_enabled
  identity {
    type = var.identity.type
    identity_ids = var.identity.identity_ids[0] == "" ? [] : [var.identity.identity_ids[0]]
  }
  customer_managed_key_id = var.customer_managed_key_id
  //customer_managed_key_identity_id = var.customer_managed_key_identity_id

  tags = var.tags
}

