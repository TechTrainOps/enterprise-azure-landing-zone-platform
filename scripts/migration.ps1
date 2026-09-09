cd "$env:BUILD_SOURCESDIRECTORY\environments\dev"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform state list | Select-String "availability_set|linux_virtual_machine|windows_virtual_machine|managed_disk|vm_extension|virtual_machine_scale_set"