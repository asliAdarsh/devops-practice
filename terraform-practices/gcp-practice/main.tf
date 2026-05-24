resource "google_compute_network" "custom_network" {
     name = "dev-vpc-network"
     auto_create_subnetworks = false
}