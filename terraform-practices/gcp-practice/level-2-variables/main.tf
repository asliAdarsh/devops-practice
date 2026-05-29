resource "google_storage_bucket" "dynamic_bucket" {
  name = "footprint-bucket-${var.environment}-${var.sandbox_suffix}"
  location = var.region
  storage_class = "STANDARD"
  force_destroy = true
  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
}