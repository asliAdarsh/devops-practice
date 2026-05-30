# GCP DevOps Infrastructure Roadmap

![Terraform](https://img.shields.io/badge/Terraform-Practices-7B42BC?style=flat-square&logo=terraform&logoColor=white)
![GCP](https://img.shields.io/badge/Google_Cloud-4285F4?style=flat-square&logo=google-cloud&logoColor=white)
![Infrastructure](https://img.shields.io/badge/IaC-Progressive-00BFA5?style=flat-square&logo=terraform&logoColor=white)

This directory contains **14 hands-on infrastructure exercises** with **Terraform on Google Cloud Platform (GCP)** — progressing from a single GCS bucket to multi-project workload identity federation. Each level builds on the previous one, forming a complete GCP DevOps learning path from **Foundations** to **Production GitOps**.

> **Journey:** A single bucket &rarr; Variables & backends &rarr; Custom VPC & compute &rarr; Modules & databases &rarr; Multi-project shared VPC &rarr; IAM cross-project guards &rarr; Secretless CI/CD with OIDC

---

## Learning Path: Foundations &rarr; Production GitOps

| Tier | Level | Theme | What You'll Learn | Folder |
|------|-------|-------|-------------------|--------|
| 🟢 Tier 0 (Foundations) | **Level 1** | The Footprint | First GCS bucket, local state, provider handshake, `force_destroy`, `public_access_prevention` | `level-1-footprint/` |
| 🟢 Tier 0 (Foundations) | **Level 2** | The Variable Lab | `variables.tf`, validation blocks, `dev.tfvars` / `prod.tfvars`, environment-aware naming | `level-2-variables/` |
| 🟢 Tier 0 (Foundations) | **Level 3** | The State Guardian | Remote `gcs` backend, state locking, state migration, corrupted state recovery | `level-3-backend/` |
| 🟡 Tier 1 (Networking) | **Level 4** | The Network Architect | Custom VPC (`auto_create_subnetworks=false`), private subnet, IAP SSH firewall (`35.235.240.0/20`) | `level-4-vpc/` |
| 🟡 Tier 1 (Networking) | **Level 5** | The Fortress | VM with **no public IP**, `data` source for existing subnet, IAP tunnel (e2-micro, Ubuntu 2204) | `level-5-compute/` |
| 🟡 Tier 1 (Networking) | **Level 6** | The Outbound Gate | Cloud Router + Cloud NAT, `LIST_OF_SUBNETWORKS`, one-way outbound traffic only | `level-6-nat/` |
| 🟠 Tier 2 (Architecture) | **Level 7** | The Architect | Reusable GCS bucket module (`source = "./modules/gcp_bucket"`), module outputs for `media-assets` & `system-logs` | `level-7-modules/` |
| 🟠 Tier 2 (Architecture) | **Level 8** | The Data Vault | Private Cloud SQL PostgreSQL, Private Service Access, VPC peering, `ipv4_enabled=false` | `level-8-database/` |
| 🟠 Tier 2 (Architecture) | **Level 9** | The Pipeline | Path-filtered monorepo CI/CD, module-backed bucket, GCS backend for pipeline state | `level-9-pipeline/` |
| 🔵 Tier 3 (Multi-Project) | **Level 10** | The Factory | Org-level project factory, `google_project` x2 (hub-net-core + spoke-app-prod), `random_id` suffix | `level-10-factory/` |
| 🔵 Tier 3 (Multi-Project) | **Level 11** | The Conduit | Shared VPC bridge, `google_compute_shared_vpc_host_project`, provider aliasing (hub/spoke) | `level-11-conduit/` |
| 🔵 Tier 3 (Multi-Project) | **Level 12** | The Gatekeeper | Cross-project IAM binding at subnet level, `google_compute_subnetwork_iam_member`, `compute.networkUser` | `level-12-gatekeeper/` |
| 🔴 Tier 4 (Production) | **Level 13** | The Guardian | PR validation pipeline + hub egress NAT, `terraform fmt -check`, plan commenter | `level-13-guardian/` |
| 🔴 Tier 4 (Production) | **Level 14** | The Master Key | Workload Identity Federation with OIDC, `principalSet`, attribute mapping, **zero static keys** | `level-14-master-key/` |

---

## Overview

This roadmap transforms a Terraform novice into a multi-project GCP infrastructure engineer. Each level introduces a critical Terraform concept while building a real-world GCP resource.

### What Makes This Roadmap Unique

- **Progressive complexity** — Each level depends logically on the previous one. You start with a single bucket and end with workload identity federation across projects.
- **Production patterns** — Every level uses production-standard practices: validation blocks, remote state, module reuse, least-privilege IAM, secretless auth.
- **Real GCP services** — You provision actual resources: GCS buckets, VPCs, subnets, firewalls, VMs, Cloud NAT, Cloud SQL, Shared VPC, IAM, Workload Identity.
- **Multi-project reality** — Levels 10-14 operate across multiple GCP projects, teaching org-level infrastructure management.
- **GitOps-ready** — Levels 9, 13, and 14 integrate with GitHub Actions, PR validation, and OIDC-based secretless authentication.

---

## Skills Practiced

- [x] Terraform provider configuration and handshake (`required_providers`, `google` provider)
- [x] Resource declaration with `google_storage_bucket` (GCS)
- [x] Variables with type constraints and validation blocks
- [x] Environment-specific `.tfvars` files (dev / prod separation)
- [x] Remote state with `backend "gcs"` configuration
- [x] State locking and migration
- [x] Custom VPC networking (`auto_create_subnetworks=false`)
- [x] Private subnet with `private_ip_google_access`
- [x] IAP-aware firewall rules (`source_ranges = ["35.235.240.0/20"]`)
- [x] Compute instances with no public IP (IAP tunnel only)
- [x] Data sources for existing infrastructure lookup
- [x] Cloud Router + Cloud NAT (`LIST_OF_SUBNETWORKS` mode)
- [x] Local modules with `source = "./modules/..."` and module outputs
- [x] Private Cloud SQL with Private Service Access (VPC peering)
- [x] Path-filtered monorepo CI/CD with GitHub Actions
- [x] Multi-project infrastructure with provider aliasing
- [x] Shared VPC (host project + service project)
- [x] Cross-project IAM at subnet level (`compute.networkUser`)
- [x] Workload Identity Federation with OIDC (`principalSet`, attribute mapping)
- [x] Secretless CI/CD authentication (no static service account keys)
- [x] Terraform formatting validation (`terraform fmt -check`)
- [x] PR automation with plan commenting

---

## Quick Reference: Run Any Level

| Level | Theme | Command |
|-------|-------|---------|
| 1 | The Footprint | `cd level-1-footprint && terraform init && terraform apply` |
| 2 | The Variable Lab | `cd level-2-variables && terraform init && terraform plan -var-file=dev.tfvars` |
| 3 | The State Guardian | `cd level-3-backend && terraform init -backend-config=bucket=YOUR_BUCKET && terraform apply -var-file=dev.tfvars` |
| 4 | The Network Architect | `cd level-4-vpc && terraform init && terraform apply -var-file=dev.tfvars` |
| 5 | The Fortress | `cd level-5-compute && terraform init && terraform apply -var-file=dev.tfvars` |
| 6 | The Outbound Gate | `cd level-6-nat && terraform init && terraform apply -var-file=dev.tfvars` |
| 7 | The Architect | `cd level-7-modules && terraform init && terraform apply` |
| 8 | The Data Vault | `cd level-8-database && terraform init && terraform apply` |
| 9 | The Pipeline | `cd level-9-pipeline && terraform init && terraform apply` |
| 10 | The Factory | `cd level-10-factory && terraform init && terraform apply` |
| 11 | The Conduit | `cd level-11-conduit && terraform init && terraform apply` |
| 12 | The Gatekeeper | `cd level-12-gatekeeper && terraform init && terraform apply` |
| 13 | The Guardian | `cd level-13-guardian && terraform init && terraform apply` |
| 14 | The Master Key | `cd level-14-master-key && terraform init && terraform apply` |

---

## How to Use This Repository

1. **Prerequisites**: Terraform >= 1.5.0, GCP project with billing enabled, `gcloud` authenticated
2. **Clone** this repository
3. **Start at Level 1** and work your way up sequentially
4. Each level has its own state isolation (local or remote GCS backend)
5. For levels 2-6, use the provided `-var-file=dev.tfvars` for development defaults
6. For levels 10-14, you'll need a GCP organization and billing account

**Before running any level:**
```bash
gcloud auth application-default login
# Or set GOOGLE_APPLICATION_CREDENTIALS to your service account key
```

---

## Badge Progression

| Reached Level | Badge |
|---------------|-------|
| Complete Level 3 | 🟢 Terraform Foundations — Provider, variables, remote state |
| Complete Level 6 | 🟡 Networking Engineer — VPC, firewall, NAT, private compute |
| Complete Level 9 | 🟠 Infrastructure Architect — Modules, databases, CI/CD |
| Complete Level 12 | 🔵 Multi-Project Operator — Shared VPC, IAM, project factory |
| Complete Level 14 | 🔴 GitOps Guardian — PR validation, workload identity federation |
