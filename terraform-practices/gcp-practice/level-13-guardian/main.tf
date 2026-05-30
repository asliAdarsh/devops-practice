
data "google_compute_network" "shared_network" { 
  name     = "shared-enterprise-vpc"
}

data "google_compute_subnetwork" "shared_subnet" {
  name     = "spoke-prod-subnet-asia"
}

resource "google_compute_router" "hub_router" {
  provider = google.hub
  name     = "shared-enterprise-router"
  region   = var.region
  network  = data.google_compute_network.shared_network.id
}

resource "google_compute_router_nat" "hub_nat" {
  provider                           = google.hub
  name                               = "shared-enterprise-nat"
  router                             = google_compute_router.hub_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = data.google_compute_subnetwork.shared_subnet.id # Pulls exact Subnet link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}