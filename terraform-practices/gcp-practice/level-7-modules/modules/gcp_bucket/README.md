# Module: gcp_bucket — Reusable GCS Bucket

A reusable Terraform module for provisioning Google Cloud Storage buckets with consistent security defaults.

## Overview
This module standardizes GCS bucket creation across the roadmap with pre-configured security settings (`force_destroy`, `public_access_prevention`, `uniform_bucket_level_access`). Used by Levels 7 and 9.

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

## Key Terraform Concepts
- **Module variables**: `required` vs `optional` inputs with descriptions
- **Module outputs**: Exposing resource attributes to module consumers
- **Security defaults**: `force_destroy = true`, `public_access_prevention = "enforced"`

## How to Use
```hcl
module "my_bucket" {
  source      = "./modules/gcp_bucket"
  bucket_name = "my-unique-bucket-name"
  location    = "ASIA-SOUTH1"
}

output "bucket_endpoint" {
  value = module.my_bucket.bucket_url
}
```
