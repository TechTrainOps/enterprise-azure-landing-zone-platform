# cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\compute"

# Write-Host "Current Terraform directory:"
# Get-Location

# terraform init -input=false

# if ($LASTEXITCODE -ne 0) {
#     throw "Terraform init failed."
# }

# terraform plan -no-color

# terraform plan

az account set --subscription "2d1634f0-7a97-4b55-b237-f5b12e52c45c"

$RG_ID = az group show `
  --name "rg-ealz-dev-eastus2" `
  --query id `
  --output tsv

$RG_ID

$REQUIRED_TAGS_POLICY_ID = az policy definition show `
  --name "require-standard-tags" `
  --query id `
  --output tsv

$REQUIRED_TAGS_POLICY_ID

$ALLOWED_REGIONS_POLICY_ID = az policy definition show `
  --name "allowed-azure-regions" `
  --query id `
  --output tsv

$ALLOWED_REGIONS_POLICY_ID

az policy definition show --name "0fdf0491-d080-4575-b627-ad0e843cba0f" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "dc921057-6b28-4fbe-9b83-f7bec05db6c2" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "e8eef0a8-67cf-4eb4-9386-14b0e78733d4" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "404c3081-a854-4457-ae30-26a93ef643f9" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "b2982f36-99f2-4db5-8eff-283140c09693" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "4fa4b6c0-31ca-4c0d-b10d-24b96f62a751" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "fd9903f1-38c2-4d36-8e44-5c1c20c561e8" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "6edd7eda-6dd8-40f7-810d-67160c639cd9" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "12d4fa5e-1f9f-4c21-97a9-b99b3c6611b5" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "405c5871-3e91-4644-8a63-58e19d68ff5b" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "0b60c0b2-2dc2-4e1c-b5c9-abbed971de53" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "e71308d3-144b-4262-b144-efdc3cc90517" --query "{name:name,id:id,displayName:displayName}" -o json
az policy definition show --name "4c3c6c5f-0d47-4402-99b8-aa543dd8bcee" --query "{name:name,id:id,displayName:displayName}" -o json


az policy assignment show `
  --name "required-tags-dev" `
  --scope "$RG_ID" `
  --query id `
  --output tsv

az policy assignment show `
  --name "allowed-regions-dev" `
  --scope "$RG_ID" `
  --query id `
  --output tsv

az policy assignment show --name "acr-public-network-access-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "acr-local-admin-disabled-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "acr-private-link-dev" --scope "$RG_ID" --query id -o tsv

az policy assignment show --name "storage-secure-transfer-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "storage-minimum-tls-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "storage-public-network-access-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "storage-blob-public-access-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "storage-shared-key-access-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "storage-private-link-dev" --scope "$RG_ID" --query id -o tsv

az policy assignment show --name "key-vault-rbac-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "key-vault-public-network-access-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "key-vault-purge-protection-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "key-vault-soft-delete-dev" --scope "$RG_ID" --query id -o tsv

az policy assignment show --name "subnet-nsg-association-dev" --scope "$RG_ID" --query id -o tsv
az policy assignment show --name "vnet-flow-logs-dev" --scope "$RG_ID" --query id -o tsv