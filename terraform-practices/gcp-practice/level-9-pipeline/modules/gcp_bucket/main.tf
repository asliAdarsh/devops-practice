resource "google_storage_bucket" "templated_bucket" {
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = "STANDARD"
  force_destroy               = true
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
}