# Level 10: The Factory — Project Factory

This level creates **two GCP projects** at the organization level: a hub project for networking and a spoke project for applications. It introduces the `google_project` resource, `random_id` for naming, and organization-level infrastructure.

## Overview
- Create `hub-net-core` project for shared networking infrastructure
- Create `spoke-app-prod` project for production applications
- Use `random_id` to generate unique project ID suffixes
- Apply labels (`tier`, `environment`, `managed_by`) for resource organization
- Reference `org_id` and `billing_account_id` for project provisioning

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Two `google_project` resources + `random_id` suffix generator |
| `providers.tf` | Provider config with GCS backend (`terraform/project-factory` prefix) |
| `variables.tf` | Variables including `org_id` and `billing_account_id` |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `random_id.suffix` | 4-byte random hex string for unique project IDs |
| `google_project.hub_net_core` | Hub networking project with `tier = "core"` label |
| `google_project.spoke_app_prod` | Spoke application project with `environment = "production"` label |

## Key Terraform Concepts
- **`google_project` resource**: Creating projects at the organization level
- **`org_id` and `billing_account_id`**: Required for project creation in an organization
- **`random_id`**: Generating unique, collision-resistant project ID suffixes
- **Labels**: Resource metadata for cost tracking and organizational grouping
- **Organization-level provisioning**: Terraform operating at the org scope rather than project scope

## Critical Takeaways
- Project creation requires `roles/ProjectCreator` IAM role at the organization level.
- Project IDs must be globally unique — `random_id` prevents naming collisions.
- The hub-and-spoke model separates networking concerns from application concerns at the project level.
- Labels are essential for cost allocation and resource organization in multi-project environments.
- Project factory patterns are the foundation of infrastructure-as-code at enterprise scale.

## How to Use
```bash
cd level-10-factory
terraform init
terraform plan
terraform apply
terraform destroy
```

## Skills Practiced
- [x] Organization-level project creation (`google_project`)
- [x] `random_id` resource for unique naming
- [x] Billing account and org ID configuration
- [x] Resource labeling for taxonomy
- [x] Hub-and-spoke project model
- [x] Multi-project architecture fundamentals
