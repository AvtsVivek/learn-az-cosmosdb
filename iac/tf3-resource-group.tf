# Terraform Resource to Create Azure Resource Group with Input Variables defined in variables.tf
# resource "azurerm_resource_group" "aks_rg" {
#   name     = "${var.resource_group_name}-${var.environment}"
#   location = var.location
# }

# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  location = var.resource_group_location
  tags     = local.common_tags
}