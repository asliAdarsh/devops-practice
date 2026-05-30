# Level 3: The State Guardian — Remote GCS Backend

This level migrates Terraform state from local filesystem to a remote GCS bucket, enabling state locking, team collaboration, and state versioning. It also explores state migration and corrupted state recovery.

## Overview
- Configure `backend "gcs"` in the `terraform` block
- Reference the bucket created in earlier levels (`footprint-bucket-dev-adarsh-sandbox-101`)
- Use a state prefix (`terraform/state`) for logical isolation
- Implement **state locking** via GCS object locking
- Handle state migration (local &rarr; remote)
- Examine a corrupted/errored state file (`errored.tfstate`) for recovery understanding

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Parameterized `google_storage_bucket` (same as Level 2) |
| `providers.tf` | `backend "gcs"` configuration with bucket and prefix |
| `variables.tf` | Variable declarations (same pattern as Level 2) |
| `dev.tfvars` | Dev environment values |
| `errored.tfstate` | Simulated corrupted state file for recovery practice |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_storage_bucket.dynamic_bucket` | Same parameterized bucket, now managed via remote state |

## Key Terraform Concepts
- **`backend "gcs"` block**: Defining remote state in the `terraform` configuration
- **State migration**: Moving from local `terraform.tfstate` to remote GCS
- **State locking**: Automatic lock via GCS object, preventing concurrent operations
- **State prefix**: Namespacing state files for multiple configurations (`terraform/state`)
- **Corrupted state recovery**: Strategies for recovering from `errored.tfstate`

## Critical Takeaways
- Remote state is **non-negotiable** for team environments — it prevents state conflicts and provides a single source of truth.
- Always configure state **before** running `terraform apply` on a shared environment.
- The GCS backend provides automatic locking via object write semantics — no separate lock table needed.
- State prefixes enable multiple Terraform configurations to share one bucket with logical isolation.
- Keep a backup of `terraform.tfstate` before migration — corrupted state can lock you out of your infrastructure.

## How to Use
```bash
cd level-3-backend

# First ensure the backend bucket exists (created in Level 1 or 2)
# Then initialize with backend config
terraform init -backend-config=bucket=footprint-bucket-dev-adarsh-sandbox-101
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

## Skills Practiced
- [x] GCS remote backend configuration (`backend "gcs"`)
- [x] State migration (local &rarr; remote)
- [x] State locking for concurrent safety
- [x] State prefix isolation
- [x] Corrupted state file recovery awareness
