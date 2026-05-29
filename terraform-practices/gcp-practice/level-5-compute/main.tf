data "google_compute_subnetwork" "existing_subnet" {
  name   = "app-subnet-${var.environment}"
  region = var.region
}


resource "google_compute_instance" "fortress_node" {
  name = "fortress-node-${var.environment}"
  machine_type = "e2-micro"
  zone = "${var.region}-a"
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.existing_subnet.id
  }

  metadata = {
    block-project-ssh-keys = "true"
  }

}