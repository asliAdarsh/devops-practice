variable "project_id" {
  type    = string
  default = "your-gcp-project-id"
}

variable "region" {
  type    = string
  default = "asia-south1"
}

variable "org_id" {
  type    = string
  default = "310558825488"
}

variable "billing_account_id" {
  type        = string
  description = "The billing account ID linked to your organization"
}