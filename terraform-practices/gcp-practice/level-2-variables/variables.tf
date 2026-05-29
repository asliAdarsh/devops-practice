variable "project_id" {
  type        = string
  description = "The target Google Cloud Project ID where credits will be spent."
}

variable "region" {
  type        = string
  default     = "asia-south1"
  description = "The target deployment region."
}

variable "environment" {
  type        = string
  description = "The deployment stage lifecycle (e.g., dev, prod, staging)."
  
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "The environment variable must be strictly set to either 'dev' or 'prod'."
  }
}

variable "sandbox_suffix" {
  type        = string
  description = "Your unique name or string to guarantee global bucket uniqueness."
}