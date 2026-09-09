# Virtual Network

Creates an Azure Virtual Network.

## Purpose

This module provides a reusable Azure Virtual Network configuration
for landing zone and workload environments.

The module supports standard VNet configuration as well as optional
DNS servers, BGP community, flow timeout, DDoS protection, encryption,
and IP address pool configuration.

## Resources

- Azure Virtual Network

## Inputs

| Name | Description | Type |
|------|-------------|------|
| name | Name of the virtual network | string |
| resource_group_name | Resource group where the virtual network is created | string |
| location | Azure region | string |
| address_space | Address spaces assigned to the virtual network | list(string) |
| dns_servers | Custom DNS server IP addresses | list(string) |
| bgp_community | BGP community for the virtual network | string |
| flow_timeout_in_minutes | Flow timeout in minutes | number |
| edge_zone | Azure Edge Zone | string |
| ddos_protection_plan | Optional DDoS Protection Plan configuration | object |
| encryption | Optional virtual network encryption configuration | object |
| ip_address_pools | Optional Azure Network Manager IPAM pools | list(object) |
| tags | Tags applied to the virtual network | map(string) |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID of the virtual network |
| name | Name of the virtual network |
| guid | GUID of the virtual network |
| address_space | Address space configured on the virtual network |
| location | Azure region of the virtual network |
| resource_group_name | Resource group containing the virtual network |