# App Cluster Module

This module provisions a DigitalOcean Droplet (virtual machine) inside an existing VPC — the compute building block for running applications.

## Overview

- Creates an **Ubuntu 24.04** Droplet with a specified size
- Attaches the Droplet to an existing **VPC** via `vpc_uuid`
- Applies **tags** for automatic firewall rule association
- Exposes the Droplet's **public IP** for external access

## Files

| File | Purpose |
|------|---------|
| `droplet.tf` | Droplet resource definition (image, size, VPC, tags) |
| `variables.tf` | Input variables for droplet configuration |
| `outputs.tf` | Exposed outputs (server_public_ip) |

## Input Variables

| Variable | Type | Description |
|----------|------|-------------|
| `droplet_name` | `string` | VM hostname (e.g., `dev-web-1`) |
| `region` | `string` | Deployment region slug (e.g., `blr1`) |
| `droplet_size` | `string` | DigitalOcean size slug (e.g., `s-1vcpu-1gb`) |
| `vpc_id` | `string` | UUID of the VPC to attach the droplet to |
| `tags` | `list(string)` | Tags for firewall linking and resource grouping |

## Outputs

| Output | Description |
|--------|-------------|
| `server_public_ip` | Public IPv4 address of the droplet |

## Key Concepts

- **Compute module abstraction** — swap droplet size or name without changing infrastructure code
- **VPC attachment via composition** — `vpc_id` is wired from the `network_layer` module output
- **Environment-agnostic** — dev and prod droplets use the same module; only input values differ
- **Tag-based security** — droplets inherit firewall rules automatically through their tags
