data "google_compute_network" "existing_vpc" {
  name = "custom-vpc-${var.environment}"
}

data "google_compute_subnetwork" "existing_subnet" {
  name   = "app-subnet-${var.environment}"
  region = var.region
}

resource "google_compute_router" "nat_router" {
  name = "nat-router-${var.environment}"
  region = var.region
  network = data.google_compute_network.existing_vpc.id
}

resource "google_compute_router_nat" "custom_nat" {
  name   = "custom-nat-${var.environment}"
  router = google_compute_router.nat_router.name
  region = var.region

  # Automatically allocate public IPs from Google's pool for outbound translation
  nat_ip_allocate_option = "AUTO_ONLY"

  # Explicitly restrict NAT translations ONLY to our specific subnetwork
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  
  subnetwork {
    name                    = data.google_compute_subnetwork.existing_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}