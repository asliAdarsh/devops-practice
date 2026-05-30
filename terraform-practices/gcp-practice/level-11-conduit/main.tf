resource "google_compute_shared_vpc_host_project" "hub_host" {
  provider = google.hub
  project  = var.hub_project_id
}

resource "google_compute_network" "shared_vpc" {
  provider                = google.hub
  name                    = "shared-enterprise-vpc"
  auto_create_subnetworks = false
  depends_on              = [google_compute_shared_vpc_host_project.hub_host]
}

resource "google_compute_subnetwork" "spoke_prod_subnet" {
  provider      = google.hub
  name          = "spoke-prod-subnet-asia"
  ip_cidr_range = "10.150.1.0/24"
  region        = var.region
  network       = google_compute_network.shared_vpc.id
}

resource "google_compute_shared_vpc_service_project" "spoke_attachment" {
  provider        = google.hub # Executed via Hub host control
  host_project    = var.hub_project_id
  service_project = var.spoke_project_id

  depends_on = [google_compute_shared_vpc_host_project.hub_host]
}