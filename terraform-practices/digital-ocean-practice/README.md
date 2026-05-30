# DigitalOcean Terraform Practices

![Terraform](https://img.shields.io/badge/Terraform-Practices-7B42BC?style=flat-square&logo=terraform&logoColor=white)
![DigitalOcean](https://img.shields.io/badge/DigitalOcean-Provider-0080FF?style=flat-square&logo=digitalocean&logoColor=white)
![IaC](https://img.shields.io/badge/IaC-Modular-00ADD8?style=flat-square&logo=terraform&logoColor=white)

This directory contains **Terraform Infrastructure-as-Code (IaC)** practices using the **DigitalOcean** provider. The project demonstrates **modular module composition**, **multi-environment provisioning**, and **infrastructure refactoring** — progressing from flat resources to reusable components.

---

## Learning Path

| Area | Module | What You'll Learn | Theme |
|------|--------|-------------------|-------|
| 🟢 Networking | `network_layer` | VPC creation, firewall rules, environment tagging | The Network Architect |
| 🟢 Compute | `app_cluster` | Droplet provisioning, VPC attachment, multi-env deployment | The Compute Runner |
| 🟠 Orchestration | Root Module | Module composition, state management, `moved` blocks | The Orchestrator |

---

## Module 1: Network Layer (The Network Architect)

**Folder:** `modules/network_layer/`

**What I Practiced:**
- Creating isolated VPCs with custom IP ranges (`10.0.0.0/16` dev, `10.1.0.0/16` prod)
- Configuring inbound firewall rules (SSH port 22, HTTP port 80) with IPv4 + IPv6
- Configuring outbound firewall rules (all TCP/UDP)
- Environment tagging (`devlopment`, `production`) for resource grouping and firewall targeting

**Files:**
| File | Purpose |
|------|---------|
| `network.tf` | VPC, tag, and firewall resource definitions |
| `variables.tf` | Module input variables (env_name, ip_range, region, firewall_name) |
| `outputs.tf` | Exposed outputs (vpc_id) |

**Quick Reference:**
```hcl
module "dev-network" {
  source       = "./modules/network_layer"
  env_name     = "devlopment"
  ip_range     = "10.0.0.0/16"
  region       = "blr1"
  firewall_name = "devlopment-firewall"
}
```

---

## Module 2: App Cluster (The Compute Runner)

**Folder:** `modules/app_cluster/`

**What I Practiced:**
- Provisioning DigitalOcean Droplets (Ubuntu 24.04) inside a VPC
- Attaching droplets to an existing network via `vpc_uuid`
- Using tags for automatic firewall association
- Deploying multiple droplets for dev (`dev-web-1`, `dev-web-2`) and single droplet for prod (`prod-web-1`)

**Files:**
| File | Purpose |
|------|---------|
| `droplet.tf` | Droplet resource definition |
| `variables.tf` | Module input variables (droplet_name, region, droplet_size, tags, vpc_id) |
| `outputs.tf` | Exposed outputs (server_public_ip) |

**Quick Reference:**
```hcl
module "dev-cluster_1" {
  source       = "./modules/app_cluster"
  droplet_name = "dev-web-1"
  region       = "blr1"
  droplet_size = "s-1vcpu-1gb"
  vpc_id       = module.dev-network.vpc_id
  tags         = ["devlopment"]
}
```

---

## Module 3: Root Orchestrator (The Orchestrator)

**Folder:** `.` (root)

**What I Practiced:**
- Composing multiple modules with inter-module dependencies (`vpc_id` chaining)
- Multi-environment orchestration via variable-driven module inputs
- Infrastructure refactoring with Terraform `moved` blocks
- Provider configuration with version constraints

**Files:**
| File | Purpose |
|------|---------|
| `main.tf` | Root module — instantiates network_layer and app_cluster for dev & prod |
| `providers.tf` | DigitalOcean provider declaration + `moved` blocks for state migration |
| `terraform.tfvars` | Variable values |
| `.terraform.lock.hcl` | Provider version lock file |

**Resources Provisioned:**
| Resource | Count | Purpose |
|----------|-------|---------|
| `digitalocean_vpc` | 2 | Dev VPC (10.0.0.0/16), Prod VPC (10.1.0.0/16) |
| `digitalocean_tag` | 2 | `devlopment`, `production` |
| `digitalocean_firewall` | 2 | Dev firewall, Prod firewall |
| `digitalocean_droplet` | 3 | dev-web-1, dev-web-2, prod-web-1 |

**Quick Reference:**
```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply infrastructure
terraform apply

# Destroy everything
terraform destroy
```

> **Note:** Requires a DigitalOcean API token set as `DIGITALOCEAN_TOKEN` environment variable.

---

## Environment Summary

| Environment | VPC Name | IP Range | Region | Droplet(s) | Size | Firewall |
|-------------|----------|----------|--------|------------|------|----------|
| **Development** | `devlopment-vpc` | `10.0.0.0/16` | `blr1` | `dev-web-1`, `dev-web-2` | `s-1vcpu-1gb` | `devlopment-firewall` |
| **Production** | `production-vpc` | `10.1.0.0/16` | `blr1` | `prod-web-1` | `s-1vcpu-1gb` | `prod-firewall` |

---

## Firewall Rules (Dev & Prod)

| Direction | Protocol | Port(s) | Source/Destination |
|-----------|----------|---------|-------------------|
| Inbound | TCP | 22 (SSH) | `0.0.0.0/0`, `::/0` |
| Inbound | TCP | 80 (HTTP) | `0.0.0.0/0`, `::/0` |
| Outbound | TCP | 1–65535 | `0.0.0.0/0`, `::/0` |
| Outbound | UDP | 1–65535 | `0.0.0.0/0`, `::/0` |

---

## State Migration (Refactoring with `moved`)

The `providers.tf` file contains `moved` blocks that demonstrate how to refactor infrastructure from flat resources into a module structure without destroying and recreating resources:

```hcl
moved {
  from = digitalocean_vpc.custom_vpc
  to   = module.development_cluster.digitalocean_vpc.custom_vpc
}

moved {
  from = digitalocean_droplet.web_server
  to   = module.development_cluster.digitalocean_droplet.web_server
}

moved {
  from = digitalocean_firewall.web_firewall
  to   = module.development_cluster.digitalocean_firewall.web_firewall
}
```

This allows Terraform to track that existing cloud resources have been reorganized into the new module hierarchy — no resource recreation needed.

---

## Key Terraform Concepts Demonstrated

| Concept | Where |
|---------|-------|
| ✅ **Reusable Modules** | `network_layer` and `app_cluster` modules called from root |
| ✅ **Module Composition** | Droplet module consumes VPC output (`vpc_id`) from network module |
| ✅ **Multi-Environment** | Same modules, different variable values for dev and prod |
| ✅ **Variables & Outputs** | Typed inputs with descriptions, exposed outputs for chaining |
| ✅ **Provider Configuration** | `digitalocean/digitalocean` provider with `~> 2.0` version constraint |
| ✅ **Refactoring (`moved`)** | Migrating flat resources into modules with zero downtime |
| ✅ **Tag-based Firewall** | Firewall rules target droplets by environment tag |
| ✅ **State Management** | `.tfstate` and `.tfstate.backup` for tracking |

---

## Skills Practiced

- [x] Writing reusable Terraform modules with clean interfaces
- [x] Multi-environment infrastructure orchestration
- [x] DigitalOcean cloud resource provisioning (VPC, Droplet, Firewall, Tag)
- [x] Network security group configuration
- [x] Infrastructure refactoring with `moved` blocks
- [x] Variable-driven configuration across environments
- [x] Module dependency chaining (output-to-input wiring)
- [x] State file management and understanding
