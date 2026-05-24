# ./modules/app_cluster/variables.tf

variable "droplet_name" {
  type        = string
  description = "The hostname for the virtual machine"
}
variable "region" {
  type        = string
  description = "The region where the virtual machine will be created"
}

variable "droplet_size" {
  type        = string
  description = "The DigitalOcean slug representing RAM/CPU configuration"
}

variable "tags" {
  type        = list(string)
  description = "Tags to assign to the droplet for firewall linking"
}

variable "vpc_id" {
  type        = string
  description = "The UUID of the network this droplet belongs to"
}