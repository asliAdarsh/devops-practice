# Level 6: The Outbound Gate — Cloud NAT

This level provisions Cloud Router and Cloud NAT to provide outbound internet access for private instances. It demonstrates one-way traffic routing — private VMs can reach the internet, but the internet cannot reach them.

## Overview
- Create a `google_compute_router` attached to the existing VPC
- Create a `google_compute_router_nat` with `AUTO_ONLY` IP allocation
- Restrict NAT to **specific subnetworks** using `LIST_OF_SUBNETWORKS` mode
- Enable NAT logging with `ERRORS_ONLY` filter for debugging
- Use data sources for existing VPC and subnet references

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Cloud Router + Cloud NAT resources with data sources |
| `providers.tf` | Provider config with GCS backend (`terraform/nat` prefix) |
| `variables.tf` | Variables for project, region, environment |
| `dev.tfvars` | Dev environment values |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_compute_router.nat_router` | Cloud Router in the existing VPC for NAT management |
| `google_compute_router_nat.custom_nat` | Cloud NAT with auto IP allocation, restricted to the app subnet |

## Key Terraform Concepts
- **Cloud Router**: Required for dynamic routing and NAT management
- **Cloud NAT**: Provides outbound internet for private instances
- **`nat_ip_allocate_option = "AUTO_ONLY"`**: Automatically allocates external IPs from Google's pool
- **`LIST_OF_SUBNETWORKS`**: Explicitly restricts NAT to selected subnets only (secure by default)
- **NAT logging**: `log_config` with `ERRORS_ONLY` for operational visibility

## Critical Takeaways
- Cloud NAT is the correct way to provide outbound internet to private GCP instances — NOT a NAT gateway VM.
- `LIST_OF_SUBNETWORKS` is a security best practice: never use `ALL_SUBNETWORKS_ALL_IP_RANGES` without explicit need.
- NAT logging with `ERRORS_ONLY` gives you visibility without incurring high log volumes.
- The Cloud Router is a regional resource — always specify the `region` explicitly.
- Cloud NAT automatically handles SNAT (Source NAT) and DNAT (Destination NAT) for outbound-only traffic.

## How to Use
```bash
cd level-6-nat
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
terraform destroy -var-file=dev.tfvars
```

## Skills Practiced
- [x] Cloud Router resource configuration
- [x] Cloud NAT resource configuration (`AUTO_ONLY`, `LIST_OF_SUBNETWORKS`)
- [x] Data sources for existing VPC and subnet
- [x] NAT subnet restriction (`subnetwork` block)
- [x] NAT logging configuration
