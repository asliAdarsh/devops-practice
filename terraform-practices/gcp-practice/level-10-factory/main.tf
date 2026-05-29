resource "random_id" "suffix" {
  byte_length = 4
}

resource "google_project" "hub_net_core" {
  name            = "hub-net-core"
  project_id      = "hub-net-core-${random_id.suffix.hex}"
  org_id          = var.org_id
  billing_account = var.billing_account_id

  labels = {
    tier        = "core"
    environment = "networking"
    managed_by  = "terraform"
  }

}

resource "google_project" "spoke_app_prod" {
  name            = "spoke-app-prod"
  project_id      = "spoke-app-prod-${random_id.suffix.hex}"
  org_id          = "310558825488"
  billing_account = var.billing_account_id

  labels = {
    tier        = "application"
    environment = "production"
    managed_by  = "terraform"
  }
}