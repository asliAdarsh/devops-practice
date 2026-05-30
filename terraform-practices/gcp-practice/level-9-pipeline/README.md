# Level 9: The Pipeline — Monorepo CI/CD

This level integrates Terraform with **GitHub Actions CI/CD** in a monorepo structure. It uses path-filtered triggers to run only when specific folders change, and provisions a bucket via the reusable module (same pattern as Level 7).

## Overview
- Implement a **GitHub Actions workflow** with path-filtered triggers
- Reuse the `gcp_bucket` module from `./modules/gcp_bucket/`
- Configure GCS backend with isolated prefix (`terraform/pipeline`)
- Add `.gitignore` for Terraform artifacts (state files, lock file, crash logs, SA keys)
- Demonstrate monorepo isolation — only the pipeline folder triggers this workflow

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Module instantiation for `pipeline-test-bucket` |
| `providers.tf` | Provider config with GCS backend (`terraform/pipeline` prefix) |
| `variables.tf` | Variables for project and region |
| `.gitignore` | Git ignore rules for Terraform artifacts and SA keys |
| `modules/gcp_bucket/` | Reusable bucket module (same as Level 7) |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `module.pipeline_test_bucket` | GCS bucket named `pipeline-success-adarsh-sandbox-101` |

## Key Terraform Concepts
- **Path-filtered triggers**: GitHub Actions workflow only runs when changes occur in `level-9-pipeline/`
- **Module reuse**: Same `gcp_bucket` module from Level 7 redeployed with different inputs
- **GCS backend for CI/CD**: Pipeline state is stored in the same backend pattern with isolated prefix
- **Monorepo isolation**: Each level has its own state, backend prefix, and CI/CD trigger path
- **`.gitignore` best practices**: Blocking `.tfstate`, `.terraform/`, `.terraform.lock.hcl`, SA keys

## Critical Takeaways
- Path filtering in monorepo CI/CD prevents unnecessary runs and reduces pipeline costs.
- The same module can be reused across different levels — Level 7 and Level 9 both use `gcp_bucket`.
- CI/CD pipelines should use a remote backend (GCS) — never local state in automation.
- Always `.gitignore` `.tfstate` files — they contain sensitive infrastructure metadata.
- Service account keys should **never** be committed — use workload identity federation instead (see Level 14).

## How to Use
```bash
cd level-9-pipeline
terraform init
terraform plan
terraform apply
terraform destroy
```

## Skills Practiced
- [x] GitHub Actions monorepo CI/CD with path filtering
- [x] Module reuse across different configurations
- [x] GCS backend for pipeline state management
- [x] Terraform `.gitignore` best practices
- [x] Monorepo isolation patterns
