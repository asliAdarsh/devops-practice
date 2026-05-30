# Level 13: The Guardian — PR Validation & Hub NAT

This level combines **GitHub Actions PR validation** with **hub egress NAT** for the shared VPC. The CI/CD pipeline validates formatting (`terraform fmt -check`) and comments plans on pull requests, while the hub NAT provides outbound internet for the shared subnet.

## Overview
- Add Cloud Router + Cloud NAT in the Hub project for shared VPC outbound internet
- Configure NAT to use `LIST_OF_SUBNETWORKS` mode, restricted to the shared subnet
- Implement a GitHub Actions workflow for PR validation
- Use `terraform fmt -check` to enforce code formatting standards
- Enable plan commenting on PRs for collaborative review

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Data sources for shared network/subnet + Cloud Router + Cloud NAT |
| `providers.tf` | Dual provider configuration (`hub`/`spoke`) + GCS backend |
| `variables.tf` | Variables for hub and spoke project IDs and region |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_compute_router.hub_router` | Cloud Router in Hub project (`shared-enterprise-router`) |
| `google_compute_router_nat.hub_nat` | Cloud NAT in Hub project for shared subnet outbound internet |

## Key Terraform Concepts
- **Hub egress NAT**: Providing outbound internet for all service projects via the Hub
- **`terraform fmt -check`**: CI/CD code formatting validation
- **PR plan commenter**: Automated infrastructure plan visibility in pull requests
- **Data sources**: Referencing shared infrastructure without recreating it
- **`LIST_OF_SUBNETWORKS`**: Restricting NAT to the spoke production subnet

## Critical Takeaways
- Hub egress NAT is the enterprise pattern — one NAT gateway serves all service projects through the shared VPC.
- `terraform fmt -check` in CI/CD enforces consistent code style across the team automatically.
- PR plan commenting bridges the gap between infrastructure-as-code and code review workflows.
- The Cloud Router and NAT in the Hub project serve all attached service projects.
- GitOps pipelines should validate formatting **before** running `terraform plan` to fail fast.

## How to Use
```bash
cd level-13-guardian
terraform init
terraform plan
terraform apply
terraform destroy
```

## Skills Practiced
- [x] Hub egress NAT for shared VPC outbound internet
- [x] `terraform fmt -check` in CI/CD validation
- [x] PR plan commenting automation
- [x] Cloud Router + Cloud NAT in multi-project context
- [x] Data sources for shared network infrastructure
- [x] GitOps validation pipeline patterns
