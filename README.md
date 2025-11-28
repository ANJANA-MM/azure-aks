# Azure Internal Developer Platform (AKS + MySQL + ACR)

This Terraform repository provisions a production-style internal platform on Azure:

- Azure Kubernetes Service (AKS)
- Azure Database for MySQL Flexible Server
- Azure Container Registry (ACR)
- Virtual Network with subnets for AKS, DB, and ingress

It is **environment-aware** (dev / stage / prod) and uses **modules** for:

- `network`
- `aks`
- `db`
- `acr`

## Structure

```bash
.
├─ main.tf
├─ providers.tf
├─ variables.tf
├─ outputs.tf
├─ environments/
│   ├─ dev/terraform.tfvars
│   ├─ stage/terraform.tfvars
│   └─ prod/terraform.tfvars
└─ modules/
    ├─ network/
    ├─ aks/
    ├─ db/
    └─ acr/
```

## Usage

1. Install Terraform, Azure CLI, and login:

```bash
az login
az account set --subscription "<your-subscription-id>"
```

2. Select or create a workspace per environment:

```bash
terraform workspace new dev      # first time
terraform workspace select dev   # afterwards
```

3. Initialize Terraform:

```bash
terraform init
```

4. Apply for a specific environment:

```bash
terraform apply -var-file="environments/dev/terraform.tfvars"
terraform apply -var-file="environments/stage/terraform.tfvars"
terraform apply -var-file="environments/prod/terraform.tfvars"
```

> **Note:** You must fill in **subscription selection** via Azure CLI and update any placeholder values in the `terraform.tfvars` files (AAD group IDs, CIDRs, etc.).

## Backends

This repo uses **local state** by default.  
For shared/team usage, configure a remote backend (Azure Storage) in `providers.tf`.
