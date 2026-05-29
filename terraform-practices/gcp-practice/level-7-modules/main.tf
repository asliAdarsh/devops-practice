module "assets_bucket" {
  source = "./modules/gcp_bucket"
  bucket_name = "media-assets-adarsh-sandbox-101"
  location    = "ASIA-SOUTH1"
}


module "logs_bucket" {
  source      = "./modules/gcp_bucket"
  bucket_name = "system-logs-adarsh-sandbox-101" 
  location    = "ASIA-SOUTH1"
}

output "assets_bucket_endpoint" {
  value = module.assets_bucket.bucket_url
}

output "logs_bucket_endpoint" {
  value = module.logs_bucket.bucket_url
}

