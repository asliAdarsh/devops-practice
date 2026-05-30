# Network Layer Module

This module provisions a DigitalOcean VPC, environment tag, and firewall — the foundational networking layer for any environment.

## Overview

- Creates an isolated **VPC** with a custom IP CIDR range
- Creates an **environment-specific tag** (`devlopment`, `production`) for resource grouping and firewall targeting
- Configures a **firewall** with SSH (22) and HTTP (80) inbound, and all TCP/UDP outbound traffic

## Files

| File | Purpose |
|------|---------|
| `network.tf` | VPC, tag, and firewall resource definitions |
| `variables.tf` | Input variables with types and descriptions |
| `outputs.tf` | Exposed outputs (vpc_id, env_tag) |

## Input Variables

| Variable | Type | Description |
|----------|------|-------------|
| `env_name` | `string` | Environment name (e.g., `devlopment`, `production`) |
| `ip_range` | `string` | VPC IP CIDR range (e.g., `10.0.0.0/16`) |
| `region` | `string` | DigitalOcean region slug (e.g., `blr1`) |
| `firewall_name` | `string` | Firewall display name (e.g., `devlopment-firewall`) |

## Outputs

| Output | Description |
|--------|-------------|
| `vpc_id` | The VPC UUID, consumed by downstream modules (e.g., `app_cluster`) |

## Firewall Rules

| Direction | Protocol | Port(s) | Source/Destination |
|-----------|----------|---------|-------------------|
| Inbound | TCP | 22 (SSH) | `0.0.0.0/0`, `::/0` |
| Inbound | TCP | 80 (HTTP) | `0.0.0.0/0`, `::/0` |
| Outbound | TCP | 1–65535 | `0.0.0.0/0`, `::/0` |
| Outbound | UDP | 1–65535 | `0.0.0.0/0`, `::/0` |

## Key Concepts

- **Reusable network abstraction** — wrap VPC + firewall + tagging into one module
- **Tag-based firewall targeting** — firewall rules apply to all droplets carrying the environment tag
- **Multi-environment readiness** — invoke this module twice (dev + prod) with different variable values
- **Module output chaining** — `vpc_id` flows to `app_cluster` module for VPC attachment
