# Terraform Practices

![Terraform](https://img.shields.io/badge/Terraform-Practices-7B42BC?style=flat-square&logo=terraform&logoColor=white)
![DigitalOcean](https://img.shields.io/badge/DigitalOcean-Provider-0080FF?style=flat-square&logo=digitalocean&logoColor=white)

This directory contains **Terraform Infrastructure-as-Code (IaC)** practices using the **DigitalOcean** provider. The project demonstrates modular infrastructure design, multi-environment setups, and key Terraform concepts.

---

## What I Practiced

### 🧱 Modular Architecture

The infrastructure is organized into reusable **Terraform modules**:

```
terraform-practices/
├── main.tf                    # Root module — orchestrates sub-modules
├── providers.tf               # Provider configuration & state migration
├── terraform.tfvars           # Variable values
├── modules/
│   ├── network_layer/         # VPC, firewall, tags
│   │   ├── network.tf         # VPC + firewall resources
│   │   ├── variables.tf       # Module inputs
│   │   └── outputs.tf         # Module outputs (vpc_id)
│   └── app_cluster/           # Compute resources
│       ├── droplet.tf         # DigitalOcean Droplet
│       ├── variables.tf       # Module inputs (name, region, size, vpc_id)
│       └── outputs.tf         # Module outputs
```

### 🌍 Multi-Environment Setup

Two environments provisioned via the same modules:

| Environment | VPC Name | IP Range | Droplet(s) | Tags |
|-------------|----------|----------|------------|------|
| **Development** | `devlopment-vpc` | `10.0.0.0/16` | `dev-web-1`, `dev-web-2` | `devlopment` |
| **Production** | `production-vpc` | `10.1.0.0/16` | `prod-web-1` | `production` |

### 🔥 Firewall Rules

The `network_layer` module creates a firewall with:

| Direction | Protocol | Port | Source/Dest |
|-----------|----------|------|-------------|
| Inbound | TCP | 22 (SSH) | `0.0.0.0/0`, `::/0` |
| Inbound | TCP | 80 (HTTP) | `0.0.0.0/0`, `::/0` |
| Outbound | TCP | 1-65535 | `0.0.0.0/0`, `::/0` |
| Outbound | UDP | 1-65535 | `0.0.0.0/0`, `::/0` |

### 🔄 State Migration

Uses Terraform's `moved` blocks to refactor infrastructure without recreation:

```hcl
moved {
  from = digitalocean_vpc.custom_vpc
  to   = module.development_cluster.digitalocean_vpc.custom_vpc
}
```

This demonstrates **refactoring** infrastructure from flat resources into modules.

---

## Files Explained

| File | Purpose |
|------|---------|
| `providers.tf` | Declares DigitalOcean provider, required version, and `moved` blocks |
| `main.tf` | Root module — instantiates network and app_cluster modules for dev & prod |
| `terraform.tfvars` | Variable values for the configuration |
| `terraform.tfstate` | State file tracking real-world resources |
| `terraform.tfstate.backup` | Automatic state backup |
| `.terraform.lock.hcl` | Provider version lock file |
| `modules/network_layer/network.tf` | VPC, tag, and firewall resource definitions |
| `modules/network_layer/variables.tf` | Input variables for the network module |
| `modules/network_layer/outputs.tf` | Outputs (vpc_id, env_tag) |
| `modules/app_cluster/droplet.tf` | DigitalOcean Droplet resource |
| `modules/app_cluster/variables.tf` | Input variables for the app cluster module |
| `modules/app_cluster/outputs.tf` | Outputs |

---

## Resources Provisioned

| Resource | Description | Provider |
|----------|-------------|----------|
| `digitalocean_vpc` | Virtual Private Cloud (isolated network) | DigitalOcean |
| `digitalocean_tag` | Environment tag for resource grouping | DigitalOcean |
| `digitalocean_firewall` | Firewall with inbound/outbound rules | DigitalOcean |
| `digitalocean_droplet` | Virtual machine (Ubuntu 24.04) | DigitalOcean |

---

## Key Terraform Concepts Demonstrated

| Concept | Where |
|---------|-------|
| ✅ **Modules** | Reusable `network_layer` and `app_cluster` modules |
| ✅ **Variables** | Input variables with types, descriptions, and defaults |
| ✅ **Outputs** | `vpc_id` exposed from network module to app module |
| ✅ **Provider Configuration** | DigitalOcean provider with version constraints |
| ✅ **State Management** | `.tfstate` and `.tfstate.backup` |
| ✅ **Refactoring (`moved`)** | Migrating flat resources into module structure |
| ✅ **Multi-Environment** | Dev and prod using same modules with different inputs |
| ✅ **Resource Dependencies** | Droplet depends on VPC via `vpc_id` |
| ✅ **Tag-based Firewall** | Firewall rules targeting tagged resources |

---

## How to Use

```bash
# Navigate to terraform-practices
cd terraform-practices

# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply infrastructure
terraform apply

# Destroy resources when done
terraform destroy
```

> **Note:** You need a DigitalOcean API token set as `DIGITALOCEAN_TOKEN` environment variable or configured in the provider.

---

## Skills Practiced

- ✅ Writing reusable Terraform modules
- ✅ Multi-environment infrastructure management
- ✅ DigitalOcean cloud resource provisioning
- ✅ Network and security group configuration
- ✅ Infrastructure refactoring with `moved` blocks
- ✅ Variable-driven configuration
- ✅ State file management
