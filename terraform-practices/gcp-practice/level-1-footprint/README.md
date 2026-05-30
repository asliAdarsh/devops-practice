# Level 1: The Footprint — First GCS Bucket

This level establishes the very first Terraform-managed resource on GCP: a single Google Cloud Storage bucket with local state management. It validates that the provider handshake works and that your authentication is properly configured.

## Overview
- Provision a GCS bucket (`google_storage_bucket`) in `asia-south1` with `STANDARD` storage class
- Use **local state** (the simplest Terraform state backend)
- Configure `force_destroy = true` for non-production teardown safety
- Enforce `public_access_prevention` and `uniform_bucket_level_access` for security hardening
- Establish the `required_providers` block and `provider "google"` configuration pattern

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Defines the `google_storage_bucket` resource |
| `providers.tf` | Terraform and provider configuration (version constraints, project, region) |
| `terraform.tfstate` | Local state file created after `terraform apply` |
| `terraform.tfstate.backup` | Automatic state backup before modifications |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_storage_bucket.footprint_bucket` | A single STANDARD bucket named `footprint-baseline-adarsh-sandbox-101` in `asia-south1` |

## Key Terraform Concepts
- **Provider block**: Configuring `provider "google"` with `project` and `region`
- **Required providers**: Pinning the `hashicorp/google` provider to `~> 5.0`
- **Local state**: Default state storage in `terraform.tfstate`
- **Resource arguments**: `force_destroy`, `public_access_prevention`, `uniform_bucket_level_access`
- **`terraform init`**: Downloads provider plugins and initializes the working directory

## Critical Takeaways
- The first resource is always the hardest — the provider handshake must succeed before anything else.
- `force_destroy = true` is essential for non-production buckets so `terraform destroy` can remove non-empty buckets.
- `public_access_prevention = "enforced"` is a GCP-specific security control that blocks public access even if IAM allows it.
- Local state is fine for learning, but dangerous for teams (no locking, no sharing).

## How to Use
```bash
cd level-1-footprint
terraform init
terraform plan
terraform apply
terraform destroy  # Clean up when done
```

## Skills Practiced
- [x] Terraform provider configuration (`required_providers`, `provider "google"`)
- [x] GCS bucket resource declaration
- [x] Local state management
- [x] Resource argument configuration (`force_destroy`, `public_access_prevention`)
- [x] Terraform init / plan / apply / destroy lifecycle
