# Level 12: The Gatekeeper — Cross-Project IAM

This level grants the Spoke project's Compute Engine service agent the `compute.networkUser` role on a specific subnet in the Hub project. It demonstrates **cross-project IAM binding** at the subnet level using dynamic identity resolution.

## Overview
- Fetch the Spoke project's metadata (`data.google_project`) to get its project number
- Fetch the existing shared subnet (`data.google_compute_subnetwork`)
- Grant `roles/compute.networkUser` to the Spoke's built-in Compute Engine service agent
- Construct the service agent identity dynamically: `service-{project_number}@compute-system.iam.gserviceaccount.com`
- Use **dual provider aliases** (`google.hub`, `google.spoke`) for cross-project access

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Data sources + `google_compute_subnetwork_iam_member` binding |
| `providers.tf` | Dual provider configuration (`hub`/`spoke`) + GCS backend |
| `variables.tf` | Variables for hub and spoke project IDs and region |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_compute_subnetwork_iam_member.spoke_compute_agent_binding` | Grants `compute.networkUser` to Spoke's compute service agent on the shared subnet |

## Key Terraform Concepts
- **`google_compute_subnetwork_iam_member`**: Subnet-level IAM binding (resource-level, not project-level)
- **Dynamic identity resolution**: `data.google_project` to fetch the Spoke's numeric project ID
- **Service agent construction**: `service-{number}@compute-system.iam.gserviceaccount.com` format
- **Multi-provider data sources**: Fetching data from both Hub and Spoke projects
- **Least-privilege IAM**: Granting only `compute.networkUser` at the subnet level (not the entire VPC)

## Critical Takeaways
- `compute.networkUser` at the subnet level is the most granular way to grant network access to service projects.
- The Compute Engine service agent (`compute-system.iam.gserviceaccount.com`) is a Google-managed identity that requires explicit subnet access.
- Dynamic identity resolution (`data.google_project`) avoids hardcoding project numbers.
- Subnet-level IAM is more secure than VPC-level IAM — it restricts access to specific subnets.
- The IAM binding always goes on the **resource owner's** provider (Hub manages the subnet IAM).

## How to Use
```bash
cd level-12-gatekeeper
terraform init
terraform plan
terraform apply
terraform destroy
```

## Skills Practiced
- [x] Subnet-level IAM binding (`google_compute_subnetwork_iam_member`)
- [x] Dynamic project number resolution (`data.google_project`)
- [x] Compute Engine service agent identity construction
- [x] `compute.networkUser` role for cross-project network access
- [x] Multi-provider data source pattern
- [x] Least-privilege IAM at the resource level
