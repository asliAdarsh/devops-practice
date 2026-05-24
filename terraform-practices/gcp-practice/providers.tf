terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.33.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "first-project-497309"
  region  = "asia-south1"
}


