# Level 8: The Data Vault — Private Cloud SQL

This level provisions a **private Cloud SQL PostgreSQL instance** accessible only via VPC peering. It introduces Private Service Access, service networking, and database security hardening.

## Overview
- Provision a `POSTGRES_15` database instance using `db-f1-micro` tier
- Configure **Private Service Access** via VPC peering
- Disable public IP (`ipv4_enabled = false`)
- Enable required APIs (`cloudresourcemanager`, `servicenetworking`)
- Allocate a `/16` private IP range for managed services
- Create a database (`clynz_production_sandbox`) within the instance

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Private IP allocation, service networking, Cloud SQL instance, and database |
| `providers.tf` | Provider config with GCS backend (`terraform/database` prefix) |
| `variables.tf` | Variables for project and region |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_compute_global_address.private_ip_alloc` | Internal IP range (`/16`) for VPC peering with managed services |
| `google_project_service.required_apis` | Enables `cloudresourcemanager` and `servicenetworking` APIs |
| `google_service_networking_connection.private_vpc_connection` | VPC peering connection for Cloud SQL |
| `google_sql_database_instance.postgres_instance` | Private PostgreSQL 15 instance (`db-f1-micro`, 10GB SSD, no public IP) |
| `google_sql_database.app_db` | Database named `clynz_production_sandbox` |

## Key Terraform Concepts
- **`ipv4_enabled = false`**: Completely removes public internet access to the database
- **`google_service_networking_connection`**: Establishes VPC peering between your VPC and Google's managed services
- **`google_compute_global_address` with `purpose = "VPC_PEERING"`**: Reserves IP range for service integration
- **`db-f1-micro`**: Smallest shared-core Cloud SQL tier for cost-optimized learning
- **`depends_on`**: Explicit dependency chain for API enablement -> peering -> instance
- **Data sources**: References the existing VPC from Level 4

## Critical Takeaways
- `ipv4_enabled = false` is the single most important security control for Cloud SQL — always set it for private databases.
- Private Service Access requires three steps: IP allocation, API enablement, and VPC peering connection.
- The `depends_on` chain is critical here: APIs must be enabled before peering, peering must complete before the instance is created.
- `db-f1-micro` (shared-core) is ideal for development but must be upgraded for production workloads.
- Always set `deletion_protection = false` for non-production databases that you plan to destroy.

## How to Use
```bash
cd level-8-database
terraform init
terraform plan
terraform apply
terraform destroy
```

## Skills Practiced
- [x] Private Service Access configuration
- [x] VPC peering for managed services
- [x] Private Cloud SQL instance (no public IP)
- [x] Internal IP range allocation (`VPC_PEERING`)
- [x] API enablement with `google_project_service`
- [x] Explicit resource dependency chains (`depends_on`)
- [x] Cost-optimized database tier selection
