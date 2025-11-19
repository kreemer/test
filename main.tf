data "azurerm_client_config" "current" {}

module "hub_and_spoke_vnet" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-ptn-hubnetworking.git?ref=705cc6f993a036cb49102708d88a077cabb5db13"


  # TODO: Extract relevant parts of var.hub_virtual_networks and only pass those to the module
  hub_virtual_networks = local.hub_virtual_networks
  enable_telemetry     = var.enable_telemetry
}
