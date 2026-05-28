resource "google_compute_network" "custom_vpc" {
  name                    = "prod-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name                     = "prod-mgmt-subnet"
  ip_cidr_range            = "10.10.10.0/24"
  region                   = "us-central1"
  network                  = google_compute_network.custom_vpc.id
  private_ip_google_access = true
}

resource "google_compute_router" "nat_router" {
  name    = "prod-nat-router"
  region  = "us-central1"
  network = google_compute_network.custom_vpc.id
}

resource "google_compute_nat" "stateful_nat" {
  name                               = "prod-cloud-nat"
  router                             = google_compute_router.nat_router.name
  region                             = "us-central1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.id
    source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
  }
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "prod-allow-secure-iap-ssh"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Strictly restricted to Google's internal IAP forwarding proxy block
  source_ranges = ["35.235.240.0/20"]
}