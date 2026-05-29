variable "bucket_name" {
  type        = string
  description = "The globally unique name of the storage bucket."
}

variable "location" {
  type        = string
  default     = "ASIA-SOUTH1"
  description = "The regional location of the bucket."
}