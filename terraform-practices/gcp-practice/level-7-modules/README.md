# Level 7: The Architect — Local Modules

This level introduces **local Terraform modules** for reusability. A single GCS bucket module is defined and instantiated twice: once for `media-assets` and once for `system-logs`. It demonstrates the DRY principle in infrastructure code.

## Overview
- Create a reusable `gcp_bucket` module in `./modules/gcp_bucket/`
- Instantiate the module twice with different `bucket_name` values
- Consume **module outputs** (`bucket_url`) for downstream references
- Use GCS backend with isolated prefix (`terraform/modules`)
- Demonstrate the power of abstraction — one module, many resources

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Two module instantiations (`assets_bucket`, `logs_bucket`) + output definitions |
| `providers.tf` | Provider config with GCS backend (`terraform/modules` prefix) |
| `variables.tf` | Variables with defaults for project and region |
| `modules/gcp_bucket/` | Reusable bucket module (see below) |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `module.assets_bucket` | GCS bucket named `media-assets-adarsh-sandbox-101` |
| `module.logs_bucket` | GCS bucket named `system-logs-adarsh-sandbox-101` |

## Key Terraform Concepts
- **Local module source**: `source = "./modules/gcp_bucket"` for referencing local module directories
- **Module inputs**: Passing `bucket_name` and `location` to the module
- **Module outputs**: `module.assets_bucket.bucket_url` and `module.logs_bucket.bucket_url`
- **Reusability**: Same module, different inputs = two distinct resources
- **Module outputs.tf**: Defining what the module exposes to its callers

## Critical Takeaways
- Modules are the fundamental unit of reuse in Terraform — always modularize repeated resource patterns.
- Local modules (`source = "./modules/..."`) are ideal for monorepo structures with shared patterns.
- Module outputs should be minimal — only expose what consumers genuinely need.
- Module versions (via registry or Git tags) enable safe upgrades across multiple configurations.
- The module boundary is a design decision: too granular = too many files, too coarse = not reusable.

## How to Use
```bash
cd level-7-modules
terraform init
terraform plan
terraform apply

# Check outputs
terraform output assets_bucket_endpoint
terraform output logs_bucket_endpoint

terraform destroy
```

## Skills Practiced
- [x] Local module creation and structure (`modules/gcp_bucket/`)
- [x] Module input variables (`variables.tf` in module)
- [x] Module output values (`outputs.tf` in module)
- [x] Module instantiation with `source` and input arguments
- [x] Consuming module outputs from root module
- [x] DRY infrastructure through module reuse
