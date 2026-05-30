# Level 4: The Network Architect — Custom VPC

This level builds a custom VPC with a private subnet and IAP-enabled SSH firewall. It introduces fundamental networking concepts in GCP: custom mode VPCs, subnets, and firewall rules.

## Overview
- Create a **custom-mode VPC** (`auto_create_subnetworks = false`)
- Add a **private subnet** (`10.0.1.0/24`) with `private_ip_google_access = true`
- Configure a **firewall rule** allowing SSH from **IAP** (`35.235.240.0/20`)
- Use GCS remote backend with isolated prefix (`terraform/vpc`)
- Establish network security baseline for all subsequent levels

## Files
| File | Purpose |
|------|---------|
| `main.tf` | VPC network, subnet, and firewall rule resources |
| `providers.tf` | Provider config with GCS backend (`terraform/vpc` prefix) |
| `variables.tf` | Variables including `vpc_name` for naming flexibility |
| `dev.tfvars` | Dev environment values (`vpc_name = "custom-vpc-dev"`) |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_compute_network.custom_vpc` | Custom-mode VPC with no auto-created subnets |
| `google_compute_subnetwork.app_subnet` | Private subnet `10.0.1.0/24` in specified region |
| `google_compute_firewall.allow_iap_ssh` | Firewall allowing TCP/22 from IAP CIDR `35.235.240.0/20` |

## Key Terraform Concepts
- **`auto_create_subnetworks = false`**: Full control over subnet topology
- **`private_ip_google_access = true`**: Allows subnet resources to access Google APIs without NAT
- **Firewall rule scoping**: `source_ranges` + `allow` blocks for granular security
- **IAP CIDR**: GCP's Identity-Aware Proxy uses `35.235.240.0/20` for SSH/RDP tunneling
- **Resource dependencies**: Implicit via `google_compute_network.custom_vpc.id` reference

## Critical Takeaways
- `auto_create_subnetworks = false` is the first step to production-grade network isolation — never use auto-mode VPCs.
- IAP tunneling (`35.235.240.0/20`) is the recommended way to access VMs without public IPs or bastion hosts.
- `private_ip_google_access` eliminates the need for NAT just for Google API access.
- Firewall rules in GCP are stateful — return traffic is automatically allowed.
- Always name subnet resources clearly (`app-subnet-{env}`) for multi-environment clarity.

## How to Use
```bash
cd level-4-vpc
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
terraform destroy -var-file=dev.tfvars
```

## Skills Practiced
- [x] Custom-mode VPC creation (`auto_create_subnetworks = false`)
- [x] Subnet provisioning with private IP Google access
- [x] IAP-aware SSH firewall rules
- [x] GCS backend with isolated state prefix
- [x] Firewall rule syntax (`allow` blocks, `source_ranges`)
