# 1. Enable Shared VPC Hosting on the Hub Project
resource "google_compute_shared_vpc_host_project" "hub" {
  project = "net-hub-prod"
}

# Dev Subnet inside the Host Project Network
resource "google_compute_subnetwork" "hub_dev_subnet" {
  name                     = "hub-subnet-us-central1-dev"
  ip_cidr_range            = "10.50.10.0/24"
  region                   = "us-central1"
  network                  = "enterprise-vpc"
  project                  = google_compute_shared_vpc_host_project.hub.project
  private_ip_google_access = true
}

# Prod Subnet inside the Host Project Network
resource "google_compute_subnetwork" "hub_prod_subnet" {
  name                     = "hub-subnet-us-central1-prod"
  ip_cidr_range            = "10.100.10.0/24"
  region                   = "us-central1"
  network                  = "enterprise-vpc"
  project                  = google_compute_shared_vpc_host_project.hub.project
  private_ip_google_access = true
}

# 2. Attach the Development Spoke Project to the Host
resource "google_compute_shared_vpc_service_project" "dev_spoke" {
  host_project    = google_compute_shared_vpc_host_project.hub.project
  service_project = "app-dev-spoke"
}

# 3. Attach the Production Spoke Project to the Host
resource "google_compute_shared_vpc_service_project" "prod_spoke" {
  host_project    = google_compute_shared_vpc_host_project.hub.project
  service_project = "app-prod-spoke"
}

# Grant Dev Service Account access to use the Dev Subnet ONLY
resource "google_compute_subnetwork_iam_member" "dev_subnet_user" {
  project    = google_compute_shared_vpc_host_project.hub.project
  region     = google_compute_subnetwork_hub_dev_subnet.region
  subnetwork = google_compute_subnetwork.hub_dev_subnet.name
  role       = "roles/compute.networkUser"
  
  # Target the Google API Service Account of the Dev Spoke Project
  member     = "serviceAccount:service-app-dev-spoke@compute-system.iam.gserviceaccount.com"
}