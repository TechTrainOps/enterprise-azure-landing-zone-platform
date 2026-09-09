cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\compute"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform plan -no-color | Select-String -Pattern "linux_virtual_machine_scale_set" -Context 0,80

terraform plan