variable "project_id" {
  type    = string
  default = "your-gcp-project-id"
}

variable "region" {
  type    = string
  default = "asia-south1"
}

variable "service_account_email" {
  type        = string
  description = "The email address of your existing pipeline service account"
}

variable "github_repository_path" {
  type        = string
  description = "Your GitHub path formatted exactly as: username/repository-name"
}