module "private_dns_resolver" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-dnsresolver.git?ref=1c3bf337e6e7acad9d3a7709e62859e0d41c3110" # 0.7.5

  name                        = local.private_dns_resolver.name
  resource_group_name         = local.private_dns_resolver.resource_group_name
  location                    = local.private_dns_resolver.location
  virtual_network_resource_id = local.private_dns_resolver.vnet_resource_id

  inbound_endpoints = local.private_dns_resolver.inbound_endpoints

  enable_telemetry = var.enable_telemetry
  tags             = var.tags
}
