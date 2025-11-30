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


module "bastion_host" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-bastionhost.git?ref=7c7d294caf81377671b99687aa75726e1072002e" # v0.9.0

  for_each = local.bastion_hosts

  name                   = try(each.value.name, "snap-bastion-${each.key}")
  resource_group_name    = each.value.resource_group_name
  location               = each.value.location
  copy_paste_enabled     = try(each.value.copy_paste_enabled, false)
  diagnostic_settings    = try(each.value.diagnostic_settings, null)
  enable_telemetry       = var.enable_telemetry
  file_copy_enabled      = try(each.value.file_copy_enabled, false)
  ip_configuration       = each.value.ip_configuration
  ip_connect_enabled     = try(each.value.ip_connect_enabled, false)
  kerberos_enabled       = try(each.value.kerberos_enabled, false)
  lock                   = try(each.value.lock, null)
  role_assignments       = try(each.value.role_assignments, {})
  scale_units            = try(each.value.scale_units, 2)
  shareable_link_enabled = try(each.value.shareable_link_enabled, false)
  sku                    = try(each.value.sku, "Standard")
  tags                   = try(each.value.tags, var.tags)
  tunneling_enabled      = try(each.value.tunneling_enabled, false)
  virtual_network_id     = try(each.value.virtual_network_id, null)
}
