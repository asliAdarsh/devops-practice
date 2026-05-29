resource "google_storage_bucket" "footprint_bucket" {
  name     = "footprint-baseline-adarsh-sandbox-101"
  location = "asia-south1"
  storage_class = "STANDARD"
  force_destroy = true
  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
}