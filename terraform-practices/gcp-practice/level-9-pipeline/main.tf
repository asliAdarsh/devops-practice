module "pipeline_test_bucket"{
  source      = "./modules/gcp_bucket"
  bucket_name = "pipeline-success-adarsh-sandbox-101" 
  location    = "ASIA-SOUTH1"
}