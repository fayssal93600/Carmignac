resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = var.resource_id
    is_manual_connection           = false
    subresource_names              = [ var.subresource_name ]
  }

  tags = var.tags

  # This resource depends on whatever the variable
  # depends on, indirectly. This is the same
  # as using var.storage_account_depends_on in
  # an expression above, but for situations where
  # we don't actually need the value.
  depends_on = [var.endpoint_depends_on]
}