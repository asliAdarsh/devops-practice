resource "digitalocean_droplet" "web_server" {
  image    = "ubuntu-24-04-x64"
  name     = var.droplet_name
  region   = var.region
  size     = var.droplet_size
  vpc_uuid = var.vpc_id
  tags     = var.tags
}