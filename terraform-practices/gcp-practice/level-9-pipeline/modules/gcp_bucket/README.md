# Module: gcp_bucket — Reusable GCS Bucket (Pipeline)

A reusable Terraform module for provisioning Google Cloud Storage buckets with consistent security defaults. Identical to the module used in Level 7.

## Overview
This module standardizes GCS bucket creation with pre-configured security settings (`force_destroy`, `public_access_prevention`, `uniform_bucket_level_access`). Used by the Level 9 CI/CD pipeline.

## Files
| File | Purpose |
|------|---------|
| `main.tf` | `google_storage_bucket` resource definition with security defaults |
| `variables.tf` | Input variables: `bucket_name` (required), `location` (optional, default `ASIA-SOUTH1`) |
| `outputs.tf` | Output: `bucket_url` — the full URL of the created bucket |

## Inputs
| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `bucket_name` | `string` | — | The globally unique name of the storage bucket |
| `location` | `string` | `"ASIA-SOUTH1"` | The regional location of the bucket |

## Outputs
| Output | Description |
|--------|-------------|
| `bucket_url` | The secure URL endpoint of the provisioned bucket |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_storage_bucket.templated_bucket` | STANDARD bucket with security hardening |

## How to Use
```hcl
module "pipeline_bucket" {
  source      = "./modules/gcp_bucket"
  bucket_name = "pipeline-unique-bucket"
  location    = "ASIA-SOUTH1"
}
```
