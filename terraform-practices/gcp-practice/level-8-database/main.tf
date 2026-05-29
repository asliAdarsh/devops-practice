data "google_compute_network" "existing_vpc" {
  name = "custom-vpc-dev" # Direct hook into your Level 4 network
}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc-database"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16 # Reserves a /16 block for managed services routing
  network       = data.google_compute_network.existing_vpc.id
}

resource "google_project_service" "required_apis" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com"
  ])
  
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = data.google_compute_network.existing_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges   = [google_compute_global_address.private_ip_alloc.name]
  depends_on              = [google_project_service.required_apis]
}


resource "google_sql_database_instance" "postgres_instance" {
  name             = "postgres-db-sandbox"
  database_version = "POSTGRES_15"
  region           = var.region
  depends_on       = [google_service_networking_connection.private_vpc_connection]

  # Configuration settings optimized to protect your credit pool balance
  settings {
    tier             = "db-f1-micro" # Smallest available shared-core instance shape
    disk_size        = 10            # 10 GB minimal baseline storage allocation
    disk_type        = "PD_SSD"
    availability_type = "ZONAL"      # Disables costly Multi-Zone high availability replication

    ip_configuration {
      ipv4_enabled    = false # CRUCIAL SECURITY FLAG: Completely strips away global public IP endpoints
      private_network = data.google_compute_network.existing_vpc.id # Binds database directly into your network
    }
  }
  
  deletion_protection = false
}

resource "google_sql_database" "app_db" {
  name     = "clynz_production_sandbox"
  instance = google_sql_database_instance.postgres_instance.name
}