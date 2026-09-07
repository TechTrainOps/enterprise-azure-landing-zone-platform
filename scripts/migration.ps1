$ErrorActionPreference = "Stop"

Write-Host "============================================================"
Write-Host "Networking Terraform State Migration"
Write-Host "============================================================"

$repoRoot = "$(System.DefaultWorkingDirectory)"
$oldRoot = Join-Path $repoRoot "environments\dev"
$newRoot = Join-Path $repoRoot "environments\dev\networking"

Write-Host "Repository Root : $repoRoot"
Write-Host "Old Terraform Root : $oldRoot"
Write-Host "New Terraform Root : $newRoot"


# ============================================================
# Helper: Run Terraform and fail on non-zero exit code
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
        throw "Terraform command failed with exit code $LASTEXITCODE : terraform $($Arguments -join ' ')"
    }
}


# ============================================================
# Helper: Get Terraform resource ID from state
# ============================================================

function Get-TerraformResourceId {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Address
    )

    $output = & terraform state show -no-color $Address 2>&1

    if ($LASTEXITCODE -ne 0) {
        throw "Unable to read Terraform state for: $Address"
    }

    $idLine = $output |
        Where-Object { $_ -match '^\s*id\s*=' } |
        Select-Object -First 1

    if (-not $idLine) {
        throw "Could not find an ID in Terraform state for: $Address"
    }

    if ($idLine -match 'id\s*=\s*"([^"]+)"') {
        return $Matches[1]
    }

    throw "Could not parse resource ID from Terraform state for: $Address"
}


# ============================================================
# Networking resources expected in OLD state
# ============================================================

$resources = @(
    "module.vnet.azurerm_virtual_network.vnet",

    "module.subnet.azurerm_subnet.subnet",

    "module.nsg.azurerm_network_security_group.nsg",

    "module.subnet_nsg_association.azurerm_subnet_network_security_group_association.association",

    "module.route_table.azurerm_route_table.route_table",

    "module.subnet_route_table_association.azurerm_subnet_route_table_association.association",

    "module.nat_public_ip.azurerm_public_ip.public_ip",

    "module.nat_gateway.azurerm_nat_gateway.nat_gateway",

    "module.nat_gateway_public_ip_association.azurerm_nat_gateway_public_ip_association.association",

    "module.nat_gateway_subnet_association.azurerm_subnet_nat_gateway_association.association",

    "module.nsg_rules.azurerm_network_security_rule.rule[\"allow_https_inbound\"]",

    "module.nsg_rules.azurerm_network_security_rule.rule[\"allow_https_outbound\"]",

    "module.private_dns_zone.azurerm_private_dns_zone.private_dns_zone",

    "module.private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link",

    "module.storage_private_dns_zone.azurerm_private_dns_zone.private_dns_zone",

    "module.storage_private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link",

    "module.acr_private_dns_zone.azurerm_private_dns_zone.private_dns_zone",

    "module.acr_private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link",

    "module.bastion_subnet.azurerm_subnet.subnet",

    "module.bastion_public_ip.azurerm_public_ip.public_ip",

    "module.bastion.azurerm_bastion_host.bastion"
)


# ============================================================
# STEP 1
# Initialize OLD Terraform root
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 1 - Initialize OLD Terraform root"
Write-Host "============================================================"

Set-Location $oldRoot

Invoke-Terraform @(
    "init",
    "-input=false"
)


# ============================================================
# STEP 2
# Verify expected resources exist in OLD state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 2 - Verify Networking resources exist in OLD state"
Write-Host "============================================================"

$oldStateList = & terraform state list 2>&1

if ($LASTEXITCODE -ne 0) {
    throw "Unable to list resources from OLD Terraform state."
}

foreach ($address in $resources) {

    if ($oldStateList -notcontains $address) {
        throw "Expected Networking resource is missing from OLD state: $address"
    }

    Write-Host "FOUND: $address"
}

Write-Host ""
Write-Host "All expected Networking resources exist in OLD state."


# ============================================================
# STEP 3
# Capture IDs from OLD Terraform state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 3 - Capture Azure resource IDs from OLD state"
Write-Host "============================================================"

$resourceIds = @{}

foreach ($address in $resources) {

    $id = Get-TerraformResourceId -Address $address

    $resourceIds[$address] = $id

    Write-Host ""
    Write-Host "$address"
    Write-Host "  ID: $id"
}


# ============================================================
# STEP 4
# Verify Azure resources exist
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 4 - Verify Azure resources"
Write-Host "============================================================"

# These are actual Azure resources that can be verified directly.
$directAzureResources = @(
    "module.vnet.azurerm_virtual_network.vnet",
    "module.subnet.azurerm_subnet.subnet",
    "module.nsg.azurerm_network_security_group.nsg",
    "module.route_table.azurerm_route_table.route_table",
    "module.nat_public_ip.azurerm_public_ip.public_ip",
    "module.nat_gateway.azurerm_nat_gateway.nat_gateway",
    "module.nsg_rules.azurerm_network_security_rule.rule[\"allow_https_inbound\"]",
    "module.nsg_rules.azurerm_network_security_rule.rule[\"allow_https_outbound\"]",
    "module.private_dns_zone.azurerm_private_dns_zone.private_dns_zone",
    "module.private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link",
    "module.storage_private_dns_zone.azurerm_private_dns_zone.private_dns_zone",
    "module.storage_private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link",
    "module.acr_private_dns_zone.azurerm_private_dns_zone.private_dns_zone",
    "module.acr_private_dns_zone_link.azurerm_private_dns_zone_virtual_network_link.link",
    "module.bastion_subnet.azurerm_subnet.subnet",
    "module.bastion_public_ip.azurerm_public_ip.public_ip",
    "module.bastion.azurerm_bastion_host.bastion"
)

foreach ($address in $directAzureResources) {

    $id = $resourceIds[$address]

    Write-Host ""
    Write-Host "Verifying Azure resource:"
    Write-Host $id

    az resource show `
        --ids $id `
        --only-show-errors `
        --output none

    if ($LASTEXITCODE -ne 0) {
        throw "Azure resource verification failed for $address : $id"
    }

    Write-Host "Azure resource verified successfully."
}


# ============================================================
# STEP 5
# Verify association IDs against their parent resources
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 5 - Verify association IDs"
Write-Host "============================================================"

$subnetId = $resourceIds["module.subnet.azurerm_subnet.subnet"]

$expectedAssociations = @{
    "module.subnet_nsg_association.azurerm_subnet_network_security_group_association.association" = $subnetId
    "module.subnet_route_table_association.azurerm_subnet_route_table_association.association" = $subnetId
    "module.nat_gateway_subnet_association.azurerm_subnet_nat_gateway_association.association" = $subnetId
}

foreach ($address in $expectedAssociations.Keys) {

    $actualId = $resourceIds[$address]
    $expectedId = $expectedAssociations[$address]

    Write-Host ""
    Write-Host "Checking association: $address"
    Write-Host "Expected ID: $expectedId"
    Write-Host "Actual ID  : $actualId"

    if ($actualId -ne $expectedId) {
        throw "Association ID mismatch for $address"
    }

    Write-Host "Association ID verified."
}


# ============================================================
# STEP 6
# Create OLD state backup
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 6 - Backup OLD Terraform state"
Write-Host "============================================================"

$backupFile = Join-Path $repoRoot "dev-state-before-networking-migration.json"

& terraform state pull | Out-File -FilePath $backupFile -Encoding utf8

if ($LASTEXITCODE -ne 0) {
    throw "Failed to create Terraform state backup."
}

Write-Host "State backup created:"
Write-Host $backupFile


# ============================================================
# STEP 7
# Remove Networking resources from OLD state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 7 - Remove Networking resources from OLD state"
Write-Host "============================================================"

foreach ($address in $resources) {

    Write-Host ""
    Write-Host "Removing from OLD state:"
    Write-Host $address

    Invoke-Terraform @(
        "state",
        "rm",
        $address
    )

    Write-Host "Successfully removed from OLD state."
}

Write-Host ""
Write-Host "All Networking resources removed from OLD state."


# ============================================================
# STEP 8
# Verify Networking is no longer in OLD state
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 8 - Verify OLD state"
Write-Host "============================================================"

$remainingState = & terraform state list 2>&1

if ($LASTEXITCODE -ne 0) {
    throw "Unable to verify OLD state."
}

foreach ($address in $resources) {

    if ($remainingState -contains $address) {
        throw "Networking resource still exists in OLD state: $address"
    }
}

Write-Host "Verified: Networking resources are no longer in OLD state."


# ============================================================
# STEP 9
# Initialize NEW Networking root
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 9 - Initialize NEW Networking root"
Write-Host "============================================================"

Set-Location $newRoot

Invoke-Terraform @(
    "init",
    "-input=false"
)


# ============================================================
# STEP 10
# Import resources into NEW Networking state
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

    Write-Host "Successfully imported."
}


# ============================================================
# STEP 11
# Verify NEW Networking state
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
        throw "Expected resource is missing from NEW Networking state: $address"
    }

    Write-Host "FOUND in NEW state: $address"
}


# ============================================================
# STEP 12
# Run Terraform Plan
# ============================================================

Write-Host ""
Write-Host "============================================================"
Write-Host "STEP 12 - Terraform Plan"
Write-Host "============================================================"

terraform plan -input=false -detailed-exitcode

$planExitCode = $LASTEXITCODE

if ($planExitCode -eq 1) {
    throw "Terraform plan failed."
}

if ($planExitCode -eq 2) {
    throw "Terraform plan detected changes. Migration is NOT considered successful."
}

if ($planExitCode -ne 0) {
    throw "Terraform plan returned unexpected exit code: $planExitCode"
}

Write-Host ""
Write-Host "============================================================"
Write-Host "SUCCESS"
Write-Host "============================================================"
Write-Host "Networking state migration completed successfully."
Write-Host "Terraform plan returned exit code 0."
Write-Host "Expected result: 0 to add, 0 to change, 0 to destroy."