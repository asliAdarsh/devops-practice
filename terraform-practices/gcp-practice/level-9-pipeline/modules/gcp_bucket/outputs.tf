output "bucket_url" {
  value       = google_storage_bucket.templated_bucket.url
  description = "The secure URL endpoint of the provisioned bucket."
}