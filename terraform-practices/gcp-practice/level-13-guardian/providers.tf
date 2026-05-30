terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  backend "gcs" {
    bucket = "footprint-bucket-dev-adarsh-sandbox-101"
    prefix = "terraform/guardian"
  }
}

provider "google" {
  alias   = "hub"
  project = var.hub_project_id
  region  = var.region
}

provider "google" {
  alias   = "spoke"
  project = var.spoke_project_id
  region  = var.region
}
