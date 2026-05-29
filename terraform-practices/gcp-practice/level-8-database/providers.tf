terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  backend "gcs"{
  bucket = "footprint-bucket-dev-adarsh-sandbox-101"
  prefix = "terraform/database"
}
}

provider "google" {
  project     = var.project_id
  region      = var.region
}
