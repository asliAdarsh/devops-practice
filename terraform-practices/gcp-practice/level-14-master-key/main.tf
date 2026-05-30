resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "GitHub Actions Pool"
  description               = "Identity pool for secretless GitHub Actions CI/CD workflows"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-provider"
  display_name                       = "GitHub Actions Provider"

  # Tells GCP to trust GitHub's token authority
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  # Maps GitHub's token claims directly to internal GCP principal attributes
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.owner"      = "assertion.repository_owner"
  }
}

resource "google_service_account_iam_member" "wif_sa_impersonation" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
  role               = "roles/iam.workloadIdentityUser"

  # CRUCIAL LEAST-PRIVILEGE GATE: Only allows your SPECIFIC repository to assume this identity
  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.github_repository_path}"
}

# =====================================================================
# 4. Outputs to feed directly into your GitHub Workflow
# =====================================================================
output "workload_identity_provider_audience_string" {
  value       = google_iam_workload_identity_pool_provider.github_provider.name
  description = "Copy this value into the provider string field of your github actions deployment workflow"
}