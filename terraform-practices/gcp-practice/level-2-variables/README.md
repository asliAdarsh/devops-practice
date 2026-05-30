# Level 2: The Variable Lab — Parameterization & Environments

This level introduces Terraform variables with type constraints, validation blocks, and environment-aware configuration files. The bucket name becomes dynamic using string interpolation with variables.

## Overview
- Parameterize bucket naming with `var.environment` and `var.sandbox_suffix`
- Implement **variable validation** (e.g., `environment` must be `"dev"` or `"prod"`)
- Create separate **`.tfvars` files** for dev and prod environments
- Use `var.project_id` and `var.region` for provider configuration
- Demonstrate `terraform plan -var-file=dev.tfvars` workflow

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Parameterized `google_storage_bucket` using `var.environment` and `var.sandbox_suffix` |
| `variables.tf` | All variable declarations with types, descriptions, defaults, and validation blocks |
| `providers.tf` | Provider configuration consuming `var.project_id` and `var.region` |
| `dev.tfvars` | Dev environment variable values |
| `prod.tfvars` | Prod environment variable values |

## Variables
| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `project_id` | `string` | — | The target GCP project ID |
| `region` | `string` | `"asia-south1"` | The target deployment region |
| `environment` | `string` | — | Deployment stage (`dev` or `prod`, validated) |
| `sandbox_suffix` | `string` | — | Unique string for global bucket uniqueness |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_storage_bucket.dynamic_bucket` | Bucket named `footprint-bucket-{env}-{suffix}` in the specified region |

## Key Terraform Concepts
- **Variable declarations**: `type`, `description`, `default`, `validation`
- **String interpolation**: `"footprint-bucket-${var.environment}-${var.sandbox_suffix}"`
- **`.tfvars` files**: Separating configuration from code
- **Variable validation**: `condition` / `error_message` blocks for input validation
- **Dev/Prod parity**: Same code, different `.tfvars` — the foundation of environment separation

## Critical Takeaways
- Variable validation catches configuration drift early — `contains(["dev", "prod"], var.environment)` prevents typos.
- `.tfvars` files enable environment-specific deployments from the same codebase.
- String interpolation creates dynamic, readable resource names.
- Always provide `description` for every variable — it becomes self-documenting infrastructure.
- Default values reduce repetition but should be used sparingly for safety-critical variables.

## How to Use
```bash
cd level-2-variables
terraform init

# Dev environment
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars

# Prod environment
terraform plan -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars

terraform destroy -var-file=dev.tfvars
```

## Skills Practiced
- [x] Variable declarations with complete type information
- [x] Variable validation blocks (`condition`, `error_message`)
- [x] Environment-specific `.tfvars` files
- [x] String interpolation in resource names
- [x] Provider configuration consuming variables
- [x] Dev/Prod environment separation via `.tfvars`
