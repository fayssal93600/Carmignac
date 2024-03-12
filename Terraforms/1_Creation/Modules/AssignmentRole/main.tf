resource "azurerm_role_assignment" "adf_user_assigned_mi_role" {
  scope                = var.scope
  role_definition_name = var.role_definition_name
  principal_id         = var.principal_id
}