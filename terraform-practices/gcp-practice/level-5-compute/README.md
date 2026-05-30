# Level 5: The Fortress — Private Compute Instance

This level provisions a VM with **no public IP address** inside the private subnet created in Level 4. It introduces data sources for looking up existing infrastructure and secure VM deployment patterns.

## Overview
- Deploy a `google_compute_instance` with **zero public IP addresses**
- Use `data "google_compute_subnetwork"` to reference the existing subnet from Level 4
- Configure an `e2-micro` instance with `ubuntu-2204-lts` boot disk
- Enable IAP-only access (no public SSH, no bastion)
- Block project-wide SSH keys via `metadata`

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Data source for subnet + compute instance resource |
| `providers.tf` | Provider config with GCS backend (`terraform/compute` prefix) |
| `variables.tf` | Variables for project, region, environment |
| `dev.tfvars` | Dev environment values |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_compute_instance.fortress_node` | A private `e2-micro` VM running Ubuntu 2204, no public IP, in the existing app subnet |

## Key Terraform Concepts
- **Data sources**: `data "google_compute_subnetwork"` to read existing infrastructure
- **No public IP**: Omitted `access_config` block = no external IP assigned
- **Machine types**: `e2-micro` (2 vCPU, 1GB RAM — free tier eligible)
- **Boot disk images**: `ubuntu-os-cloud/ubuntu-2204-lts` for the OS image
- **`block-project-ssh-keys`**: Prevents project-level SSH keys from accessing this VM

## Critical Takeaways
- Omitting `access_config` is the GCP-native way to create a VM with no public IP — no extra flags needed.
- Data sources decouple your Terraform configurations, allowing one level to reference another level's outputs.
- `e2-micro` is cost-optimized for learning — always choose the smallest instance type for practice.
- IAP tunnel (`gcloud compute ssh --tunnel-through-iap`) is the only way to access this VM.
- Blocking project-wide SSH keys is a defense-in-depth measure even in sandbox environments.

## How to Use
```bash
cd level-5-compute
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars

# Access via IAP (requires gcloud):
gcloud compute ssh fortress-node-dev --tunnel-through-iap

# Clean up
terraform destroy -var-file=dev.tfvars
```

## Skills Practiced
- [x] Data sources for existing infrastructure lookup
- [x] Private compute instance (no public IP)
- [x] `e2-micro` machine type selection
- [x] Boot disk configuration with Ubuntu 2204
- [x] Instance metadata for SSH hardening
- [x] IAP-only access pattern
