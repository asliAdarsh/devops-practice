resource "google_compute_network" "custom_vpc" {
  name = var.vpc_name
  auto_create_subnetworks = false
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "app_subnet" {
  name = "app-subnet-${var.environment}"
  region = var.region
  network = google_compute_network.custom_vpc.id
  ip_cidr_range = "10.0.1.0/24"
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name = "allow-iap-ssh-${var.environment}"
  network = google_compute_network.custom_vpc.id
  allow{
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
}