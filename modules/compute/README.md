# Compute Module Documentation

Generated documentation for the implemented compute modules in the repository.

Included modules: 8.

## Implemented modules

### `availability-set`

Creates an Azure Availability Set.

**Purpose**
- Provides fault-domain and update-domain grouping for supported virtual machine deployments.

### `linux-virtual-machine`

Creates an Azure Linux Virtual Machine and its network interface.

**Purpose**
- Provides reusable Linux VM deployment.
- Supports managed identity, SSH authentication, VM sizing, OS image configuration, networking, availability set integration, and tags.

### `managed-disk`

Creates an Azure Managed Disk.

**Purpose**
- Provides a reusable managed disk resource that can be attached to Azure compute workloads.

### `virtual-machine-extension`

Creates an Azure Virtual Machine Extension.

**Purpose**
- Provides reusable extension deployment for virtual machines.
- Supports extension publisher, type, version, settings, protected settings, and lifecycle configuration.

### `virtual-machine-scale-set`

Creates an Azure Virtual Machine Scale Set.

**Purpose**
- Provides reusable Linux VMSS deployment.
- Supports configurable instance count, VM size, networking, SSH authentication, managed identity, and VMSS configuration.

### `virtual-machine-scale-set-extension`

Creates an Azure Virtual Machine Scale Set Extension.

**Purpose**
- Provides reusable extension deployment across VMSS instances.
- Supports extension publisher, type, version, settings, and protected settings.

### `windows-virtual-machine`

Creates an Azure Windows Virtual Machine and its network interface.

**Purpose**
- Provides reusable Windows VM deployment.
- Supports managed identity, administrator authentication, VM sizing, OS image configuration, networking, availability set integration, and tags.

### `windows-vm-extension`

Creates an Azure Windows Virtual Machine Extension.

**Purpose**
- Provides reusable extension deployment for Windows virtual machines.
- Supports extension publisher, type, version, settings, protected settings, and lifecycle configuration.

**Files**
Each compute module contains:
- `main.tf`
- `variables.tf`
- `output.tf`

**Typical use**
Provides the compute layer for landing-zone workloads, including Linux and Windows virtual machines, VM Scale Sets, managed disks, availability sets, and monitoring/management extensions.

END