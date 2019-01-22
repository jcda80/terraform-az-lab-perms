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

# resource "azurerm_role_assignment" "reader-for-cadu-on-Teste-Julio" {
#   scope                = "${azurerm_resource_group.rg-1.id}"
#   role_definition_name = "Contributor"
#   principal_id         = "b2fb3938-df42-4c88-a174-93f6e10d6d48"
# }

# resource "azurerm_role_assignment" "reader-for-isouza-on-Teste-Julio" {
#  scope                = "${azurerm_resource_group.rg-1.id}"
#  role_definition_name = "Contributor-StoneCo"
#  principal_id         = "146709ad-f2ac-4df2-bfee-7d13cc5aee52"
# }

# resource "azurerm_role_assignment" "reader-for-assais-on-Teste-Julio-2" {
#   scope                = "${azurerm_resource_group.rg-2.id}"
#   role_definition_name = "Contributor"
#   principal_id         = "146709ad-f2ac-4df2-bfee-7d13cc5aee52"
# }

data "azurerm_subscription" "primary" {}

resource "azurerm_role_definition" "test" {
  name        = "CustomRole-OwnSub"
  scope       = "${data.azurerm_subscription.primary.id}"
  description = "This is a custom role created via Terraform"

  permissions {
    actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action",
                   "Microsoft.Network/networkInterfaces/join/action",
                   "Microsoft.Network/virtualNetworks/read",
                   ]
    not_actions = []
  }

  assignable_scopes = [
    "${data.azurerm_subscription.primary.id}", # /subscriptions/00000000-0000-0000-0000-000000000000
  ]
}

resource "azurerm_role_definition" "test2" {
  name        = "CustomRole-Contributor"
  scope       = "${data.azurerm_subscription.primary.id}"
  description = "This is a custom role created via Terraform"

  permissions {
    actions     = ["*"]
    not_actions = ["Microsoft.Network/virtualNetworks/write",
                   "Microsoft.Authorization/*/Delete",
                   "Microsoft.Authorization/*/Write",
                   "Microsoft.Authorization/elevateAccess/Action",
                   "Microsoft.Blueprint/blueprintAssignments/write",
                   "Microsoft.Blueprint/blueprintAssignments/delete",
                   ]
  }

  assignable_scopes = [
    "${data.azurerm_subscription.primary.id}", # /subscriptions/00000000-0000-0000-0000-000000000000
  ]
}
