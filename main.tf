provider "azurerm" {
}

resource "azurerm_resource_group" "rg-1" {
  name     = "ResourceGroup-PRD"
  location = "eastus"
}

resource "azurerm_resource_group" "rg-2" {
  name     = "ResourceGroup-DEV"
  location = "eastus"
}

resource "azurerm_role_assignment" "reader-for-cadu-on-Teste-Julio" {
  scope                = "${azurerm_resource_group.rg-1.id}"
  role_definition_name = "Contributor"
  principal_id         = "b2fb3938-df42-4c88-a174-93f6e10d6d48"
}
resource "azurerm_role_assignment" "reader-for-isouza-on-Teste-Julio" {
  scope                = "${azurerm_resource_group.rg-1.id}"
  role_definition_name = "Contributor"
  principal_id         = "146709ad-f2ac-4df2-bfee-7d13cc5aee52"
}

resource "azurerm_role_assignment" "reader-for-assais-on-Teste-Julio-2" {
  scope                = "${azurerm_resource_group.rg-2.id}"
  role_definition_name = "Reader"
  principal_id         = "129c90e0-7e14-4c4d-ae91-a3c527f7b951"
}
