# Level 14: The Master Key — Workload Identity Federation

This level implements **Workload Identity Federation (WIF)** with GitHub Actions OIDC, enabling **secretless authentication** from CI/CD pipelines to GCP. No service account keys are created, stored, or exchanged — trust is established through cryptographic token exchange.

## Overview
- Create a `google_iam_workload_identity_pool` for GitHub Actions
- Create a `google_iam_workload_identity_pool_provider` with OIDC configuration
- Configure **attribute mapping** from GitHub OIDC tokens to GCP principal attributes
- Grant `roles/iam.workloadIdentityUser` to the GitHub repository-specific principal
- Output the `workload_identity_provider_audience_string` for GitHub Actions workflow configuration

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Identity pool, OIDC provider, IAM binding, and outputs |
| `providers.tf` | Provider config with GCS backend (`terraform/master-key` prefix) |
| `variables.tf` | Variables including `service_account_email` and `github_repository_path` |

## Resources Provisioned
| Resource | Description |
|----------|-------------|
| `google_iam_workload_identity_pool.github_pool` | Workload identity pool for GitHub Actions |
| `google_iam_workload_identity_pool_provider.github_provider` | OIDC provider trusting `token.actions.githubusercontent.com` |
| `google_service_account_iam_member.wif_sa_impersonation` | Grants WIF access to a specific repository for a specific SA |

## Key Terraform Concepts
- **Workload Identity Pool**: A GCP resource that groups external identities (e.g., GitHub Actions workflows)
- **OIDC Provider**: Configures trust with GitHub's OIDC issuer (`token.actions.githubusercontent.com`)
- **Attribute mapping**: Transforms GitHub token claims into GCP principal attributes:
  - `google.subject = assertion.sub`
  - `attribute.repository = assertion.repository`
  - `attribute.owner = assertion.repository_owner`
- **`principalSet`**: IAM member syntax for workload identity federation
- **Least-privilege repository scoping**: `principalSet://iam.googleapis.com/.../attribute.repository/{username}/{repo}`

## Critical Takeaways
- Workload Identity Federation **eliminates static service account keys** — the #1 security risk in CI/CD.
- OIDC token exchange is cryptographic and short-lived (no key rotation, no secret management).
- `principalSet` scoping ensures only a specific GitHub repository can impersonate the service account.
- The attribute mapping is the security boundary — map `assertion.repository` to control exactly which repo gets access.
- WIF is the **production-standard** authentication method for GitHub Actions + GCP — always prefer it over SA keys.

## How to Use
```bash
cd level-14-master-key

# Create a .lab file or pass variables directly
terraform init
terraform plan \
  -var="service_account_email=your-sa@your-project.iam.gserviceaccount.com" \
  -var="github_repository_path=your-username/your-repo"
terraform apply

# Capture the output for your GitHub Actions workflow
terraform output workload_identity_provider_audience_string
```

### GitHub Actions Workflow Integration
```yaml
jobs:
  deploy:
    permissions:
      id-token: write  # Required for OIDC token exchange
    steps:
      - uses: actions/checkout@v4
      - uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: "projects/.../locations/global/workloadIdentityPools/.../providers/..."
          service_account: "your-sa@your-project.iam.gserviceaccount.com"
      - uses: hashicorp/setup-terraform@v3
      - run: terraform init && terraform plan
```

## Skills Practiced
- [x] Workload Identity Pool creation
- [x] OIDC provider configuration with attribute mapping
- [x] `principalSet` IAM member syntax
- [x] Repository-scoped WIF access control
- [x] Secretless authentication for CI/CD
- [x] GitHub Actions OIDC token integration
- [x] Zero static key security architecture
