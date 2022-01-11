resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  #name = us-east-2
  tags = local.common_tags
}