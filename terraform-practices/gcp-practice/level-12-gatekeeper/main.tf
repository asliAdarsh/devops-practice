data "google_project" "spoke_metadata" { #Fetch Spoke Project Metadata Natively
  provider   = google.spoke
  project_id = var.spoke_project_id
}

data "google_compute_subnetwork" "shared_subnet" { #Extract Existing Shared Network and Subnet Framework from Hub
  provider = google.hub
  name     = "spoke-prod-subnet-asia"
  region   = var.region
}

resource "google_compute_subnetwork_iam_member" "spoke_compute_agent_binding" { #Cross-Project IAM Binding: Grant Network User Role over Subnet
  provider   = google.hub
  project    = var.hub_project_id
  region     = var.region
  subnetwork = data.google_compute_subnetwork.shared_subnet.name
  role       = "roles/compute.networkUser"

  # Dynamically constructs the Spoke's built-in Google Compute Engine Service Agent identity
  member     = "serviceAccount:service-${data.google_project.spoke_metadata.number}@compute-system.iam.gserviceaccount.com"
}