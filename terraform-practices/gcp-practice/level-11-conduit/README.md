# Level 11: The Conduit — Shared VPC Bridge

This level establishes a **Shared VPC** between the Hub and Spoke projects created in Level 10. It introduces provider aliasing, cross-project networking, and the shared VPC host/service project model.

## Overview
- Enable Compute Engine API in both Hub and Spoke projects
- Configure **Shared VPC host project** (`google_compute_shared_vpc_host_project`)
- Create a shared VPC network with a subnet (`10.150.1.0/24`)
- Attach the Spoke project as a **service project** (`google_compute_shared_vpc_service_project`)
- Use **provider aliasing** (`google.hub`, `google.spoke`) for cross-project resource management

## Files
| File | Purpose |
|------|---------|
| `main.tf` | API enablement, shared VPC host, shared network/subnet, service project attachment |
| `providers.tf` | Dual provider configuration with `hub` and `spoke` aliases + GCS backend |
| `variables.tf` | Variables for hub and spoke project IDs and region |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_project_service.hub_compute_api` | Enables Compute API in Hub project |
| `google_project_service.spoke_compute_api` | Enables Compute API in Spoke project |
| `google_compute_shared_vpc_host_project.hub_host` | Designates Hub as Shared VPC host project |
| `google_compute_network.shared_vpc` | Shared VPC network (`shared-enterprise-vpc`) |
| `google_compute_subnetwork.spoke_prod_subnet` | Subnet `10.150.1.0/24` in the shared VPC |
| `google_compute_shared_vpc_service_project.spoke_attachment` | Attaches Spoke as service project to Hub |

## Key Terraform Concepts
- **Provider aliasing**: `provider "google" { alias = "hub" }` and `provider "google" { alias = "spoke" }`
- **`google_compute_shared_vpc_host_project`**: Designates a project as the Shared VPC host
- **`google_compute_shared_vpc_service_project`**: Attaches a service project to the host
- **Cross-project resources**: Creating a VPC in one project while granting access to another
- **`depends_on` chains**: API enablement -> host attachment -> network creation -> service attachment

## Critical Takeaways
- Provider aliasing is how Terraform manages resources across multiple GCP projects in a single configuration.
- Shared VPC enables centralized network administration with delegated subnet usage to service projects.
- The API enablement (`compute.googleapis.com`) must happen **before** any VPC or shared VPC operations.
- Service projects inherit the host project's network but still need the Compute API enabled.
- The Shared VPC host project controls all firewall rules and network policies centrally.

## How to Use
```bash
cd level-11-conduit
terraform init
terraform plan
terraform apply
terraform destroy
```

## Skills Practiced
- [x] Provider aliasing for multi-project configurations
- [x] Shared VPC host project designation
- [x] Shared VPC network and subnet creation
- [x] Service project attachment
- [x] Cross-project API enablement
- [x] Multi-provider resource dependency management
