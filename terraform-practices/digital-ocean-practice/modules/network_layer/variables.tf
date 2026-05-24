variable "env_name" {
  type        = string
  description = "The environment name (e.g., dev, staging, prod)"
}
variable "ip_range" {
  type        = string
  description = "The IP range for the VPC"
}
variable "region" {
  type        = string
  description = "The region where resources will be created"
}
variable "firewall_name" {
  type        = string
  description = "The name of the firewall"
}