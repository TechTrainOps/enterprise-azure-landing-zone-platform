$terraformRoots = @(
    "compute",
    "governance",
    "identity",
    "monitoring",
    "networking",
    "resource-groups",
    "security"
)

$basePath = "$env:BUILD_SOURCESDIRECTORY\environments\dev"

foreach ($root in $terraformRoots) {

    Write-Host ""
    Write-Host "============================================================"
    Write-Host "Checking Terraform root: $root"
    Write-Host "============================================================"

    $rootPath = Join-Path $basePath $root

    Set-Location $rootPath

    Write-Host "Current Terraform directory:"
    Get-Location

    Write-Host ""
    Write-Host "=== Terraform Init ==="

    terraform init -input=false

    if ($LASTEXITCODE -ne 0) {
        throw "Terraform init failed for root: $root"
    }

    Write-Host "Terraform init completed successfully."

    Write-Host ""
    Write-Host "=== Terraform Plan ==="

    terraform plan

    if ($LASTEXITCODE -ne 0) {
        throw "Terraform plan failed for root: $root"
    }

    Write-Host ""
    Write-Host "Terraform plan completed successfully for root: $root"
}

Write-Host ""
Write-Host "============================================================"
Write-Host "All Terraform roots validated successfully."
Write-Host "============================================================"