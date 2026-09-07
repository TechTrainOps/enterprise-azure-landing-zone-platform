$ErrorActionPreference = "Stop"

Write-Host "============================================================"
Write-Host "Networking Terraform State Migration"
Write-Host "============================================================"

$repoRoot = "$(System.DefaultWorkingDirectory)"
$oldRoot  = Join-Path $repoRoot "environments\dev"
$newRoot  = Join-Path $repoRoot "environments\dev\networking"

Write-Host "Repository Root : $repoRoot"
Write-Host "Old Terraform Root : $oldRoot"
Write-Host "New Terraform Root : $newRoot"


# ============================================================
# Helper function
# ============================================================

function Invoke-Terraform {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    Write-Host ""
    Write-Host "Running: terraform $($Arguments -join ' ')"

    & terraform @Arguments

    if ($LASTEXITCODE -ne 0) {
        throw "Terraform command failed with exit code $LASTEXITCODE"
    }
}


# ============================================================
# Helper function to get resource ID from Terraform state
# ============================================================

function Get-TerraformResourceId {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Address
    )

    Write-Host ""
    Write-Host "Reading ID from old state:"
    Write-Host $Address

    $output = & terraform state show -no-color $Address 2>&1

    if ($LASTEXITCODE -ne 0) {
        throw "terraform state show failed for: $Address"
    }

    $idLine = $output |
        Where-Object {
            $_ -match '^\s*id\s*='
        } |
        Select-Object -First 1

    if (-not $idLine) {
        throw "Could not find ID in Terraform state for: $Address"
    }

    if ($idLine -match 'id\s*=\s*"([^"]+)"') {
        return $Matches[1]
    }

    throw "Could not parse resource ID for: $Address"
}


# ============================================================
# Networking resources in OLD monolithic state
# ============================================================

$resources = @(
    'module.vnet.azurerm_virtual_network.vnet',

    'module.subnet.azurerm_subnet.subnet',

    'module.nsg.azurerm_network_security_group.nsg',

    'module.subnet_nsg_association.azurerm_subnet_network_security_group_association.association',

    'module.route_table.azurerm_route_table.route_table',

    'module.subnet_route_table_association.azurerm_subnet_route_table_association.association',

    'module.nat_public_ip.azurerm_public_ip.public_ip',

    'module.nat_gateway.azurerm_nat_gateway.nat_gateway',

    'module.nat_gateway_public_ip_association.azurerm_nat_gateway_public_ip_association.association',

    'module.nat_gateway_subnet_association.azurerm_subnet_nat_gateway_association.association',

    'module.nsg_rules.azurerm_network_security_rule.rule["allow_https_inbound"]',

    'module.nsg_rules.azurerm_network_security_rule.rule["allow_https_outbound"]',

    'module.private_dns_zone.azurerm_private_dns_zone.private_dns_zone',

    'module.private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link',

    'module.storage_private_dns_zone.azurerm_private_dns_zone.private_dns_zone',

    'module.storage_private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link',

    'module.acr_private_dns_zone.azurerm_private_dns_zone.private_dns_zone',

    'module.acr_private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link',

    'module.bastion_subnet.azurerm_subnet.subnet',

    'module.bastion_public_ip.azurerm_public_ip.public_ip',

    'module.bastion.azurerm_bastion_host.bastion'
)


# ============================================================
# STEP 1
# Initialize OLD Terraform root
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 1 - Initialize OLD Terraform root"
Write-Host "============================================================"

if (-not (Test-Path $oldRoot)) {
    throw "OLD Terraform root does not exist: $oldRoot"
}

Set-Location $oldRoot

Invoke-Terraform @(
    "init",
    "-input=false"
)


# ============================================================
# STEP 2
# Verify all expected resources exist in OLD state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 2 - Verify OLD state"
Write-Host "============================================================"

$oldStateList = & terraform state list 2>&1

if ($LASTEXITCODE -ne 0) {
    throw "Unable to list OLD Terraform state."
}

foreach ($address in $resources) {

    if ($oldStateList -notcontains $address) {
        throw "Resource NOT FOUND in OLD state: $address"
    }

    Write-Host "FOUND: $address"
}

Write-Host ""
Write-Host "All expected Networking resources exist in OLD state."


# ============================================================
# STEP 3
# Capture IDs from OLD state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 3 - Capture resource IDs"
Write-Host "============================================================"

$resourceIds = @{}

foreach ($address in $resources) {

    $id = Get-TerraformResourceId -Address $address

    if ([string]::IsNullOrWhiteSpace($id)) {
        throw "Empty resource ID returned for: $address"
    }

    $resourceIds[$address] = $id

    Write-Host ""
    Write-Host "Address:"
    Write-Host $address
    Write-Host "ID:"
    Write-Host $id
}


# ============================================================
# STEP 4
# Verify captured IDs
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 4 - Verify captured IDs"
Write-Host "============================================================"

foreach ($address in $resources) {

    $id = $resourceIds[$address]

    if ([string]::IsNullOrWhiteSpace($id)) {
        throw "Missing ID for resource: $address"
    }

    Write-Host "Verified ID for: $address"
}


# ============================================================
# STEP 5
# Verify actual Azure resources
#
# Association resources are Terraform-specific resources and
# are therefore excluded from az resource show verification.
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 5 - Verify Azure resources"
Write-Host "============================================================"

$azureResources = @(
    'module.vnet.azurerm_virtual_network.vnet',

    'module.subnet.azurerm_subnet.subnet',

    'module.nsg.azurerm_network_security_group.nsg',

    'module.route_table.azurerm_route_table.route_table',

    'module.nat_public_ip.azurerm_public_ip.public_ip',

    'module.nat_gateway.azurerm_nat_gateway.nat_gateway',

    'module.nsg_rules.azurerm_network_security_rule.rule["allow_https_inbound"]',

    'module.nsg_rules.azurerm_network_security_rule.rule["allow_https_outbound"]',

    'module.private_dns_zone.azurerm_private_dns_zone.private_dns_zone',

    'module.private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link',

    'module.storage_private_dns_zone.azurerm_private_dns_zone.private_dns_zone',

    'module.storage_private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link',

    'module.acr_private_dns_zone.azurerm_private_dns_zone.private_dns_zone',

    'module.acr_private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link',

    'module.bastion_subnet.azurerm_subnet.subnet',

    'module.bastion_public_ip.azurerm_public_ip.public_ip',

    'module.bastion.azurerm_bastion_host.bastion'
)

foreach ($address in $azureResources) {

    $id = $resourceIds[$address]

    Write-Host ""
    Write-Host "Checking Azure resource:"
    Write-Host $id

    az resource show `
        --ids $id `
        --only-show-errors `
        --output none

    if ($LASTEXITCODE -ne 0) {
        throw "Azure resource does not exist or cannot be accessed: $id"
    }

    Write-Host "Azure resource exists."
}


# ============================================================
# STEP 6
# Backup OLD Terraform state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 6 - Backup OLD state"
Write-Host "============================================================"

$backupFile = Join-Path $repoRoot "dev-state-before-networking-migration.json"

$stateBackup = & terraform state pull 2>&1

if ($LASTEXITCODE -ne 0) {
    throw "Failed to pull OLD Terraform state."
}

$stateBackup | Set-Content -Path $backupFile -Encoding UTF8

if (-not (Test-Path $backupFile)) {
    throw "State backup file was not created: $backupFile"
}

Write-Host "State backup created:"
Write-Host $backupFile


# ============================================================
# STEP 7
# Remove resources from OLD state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 7 - Remove Networking resources from OLD state"
Write-Host "============================================================"

foreach ($address in $resources) {

    Write-Host ""
    Write-Host "Removing:"
    Write-Host $address

    Invoke-Terraform @(
        "state",
        "rm",
        $address
    )

    Write-Host "Removed successfully."
}


# ============================================================
# STEP 8
# Verify resources are gone from OLD state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 8 - Verify OLD state after removal"
Write-Host "============================================================"

$oldStateAfterRemoval = & terraform state list 2>&1

if ($LASTEXITCODE -ne 0) {
    throw "Unable to read OLD state after removal."
}

foreach ($address in $resources) {

    if ($oldStateAfterRemoval -contains $address) {
        throw "Resource still exists in OLD state: $address"
    }
}

Write-Host "Verified: all Networking resources were removed from OLD state."


# ============================================================
# STEP 9
# Initialize NEW Networking root
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 9 - Initialize NEW Networking root"
Write-Host "============================================================"

if (-not (Test-Path $newRoot)) {
    throw "NEW Networking root does not exist: $newRoot"
}

Set-Location $newRoot

Invoke-Terraform @(
    "init",
    "-input=false"
)


# ============================================================
# STEP 10
# Import resources into NEW state
#
# IMPORTANT:
# We use the exact IDs captured from the OLD Terraform state.
# This avoids manually constructing import IDs.
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 10 - Import Networking resources"
Write-Host "============================================================"

foreach ($address in $resources) {

    $id = $resourceIds[$address]

    Write-Host ""
    Write-Host "Importing:"
    Write-Host "Address: $address"
    Write-Host "ID     : $id"

    Invoke-Terraform @(
        "import",
        $address,
        $id
    )

    Write-Host "Imported successfully."
}


# ============================================================
# STEP 11
# Verify NEW state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 11 - Verify NEW Networking state"
Write-Host "============================================================"

$newStateList = & terraform state list 2>&1

if ($LASTEXITCODE -ne 0) {
    throw "Unable to list NEW Networking state."
}

foreach ($address in $resources) {

    if ($newStateList -notcontains $address) {
        throw "Resource missing from NEW state: $address"
    }

    Write-Host "FOUND in NEW state: $address"
}


# ============================================================
# STEP 12
# Terraform Plan
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 12 - Terraform Plan"
Write-Host "============================================================"

& terraform plan -input=false -detailed-exitcode

$planExitCode = $LASTEXITCODE

if ($planExitCode -eq 1) {
    throw "Terraform plan FAILED."
}

if ($planExitCode -eq 2) {
    throw "Terraform plan detected changes. Expected 0 to add, 0 to change, 0 to destroy."
}

if ($planExitCode -ne 0) {
    throw "Terraform plan returned unexpected exit code: $planExitCode"
}


# ============================================================
# SUCCESS
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "NETWORKING STATE MIGRATION SUCCESSFUL"
Write-Host "============================================================"

Write-Host "OLD state no longer contains Networking resources."
Write-Host "NEW Networking state contains all expected resources."
Write-Host "Terraform plan returned exit code 0."
Write-Host "Expected result: 0 to add, 0 to change, 0 to destroy."