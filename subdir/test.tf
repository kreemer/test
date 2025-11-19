module "ddos_protection_plan" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-ddosprotectionplan.git?ref=2d455cb9c6c61e9061730ba8373b103ae6886cbb"

  count = local.ddos_protection_plan_enabled ? 1 : 0

  name                = local.ddos_protection_plan.name
  resource_group_name = local.ddos_protection_plan.resource_group_name
  location            = local.ddos_protection_plan.location
  enable_telemetry    = var.enable_telemetry
  tags                = var.tags
}

data "azurerm_client_config" "current" {}

module "hub_and_spoke_vnet" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-ptn-hubnetworking.git?ref=705cc6f993a036cb49102708d88a077cabb5db13"


  # TODO: Extract relevant parts of var.hub_virtual_networks and only pass those to the module
  hub_virtual_networks = local.hub_virtual_networks
  enable_telemetry     = var.enable_telemetry
}

