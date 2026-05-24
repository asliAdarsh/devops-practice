resource "digitalocean_vpc" "web_vpc" {
  name = "${var.env_name}-vpc"
  ip_range = var.ip_range
  region = var.region
}

resource "digitalocean_tag" "env_tag" {
  name = var.env_name
}

resource "digitalocean_firewall" "web_firewall" {
  name = var.firewall_name
  tags = [digitalocean_tag.env_tag.id]
    
  inbound_rule {
    protocol = "tcp"
    port_range = "22" // SSH port
    source_addresses = ["0.0.0.0/0", "::/0"] // Allow SSH from anywhere
  }
  inbound_rule {
    protocol = "tcp"
    port_range = "80" // HTTP port
    source_addresses = ["0.0.0.0/0", "::/0"] // Allow HTTP from anywhere
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"] // Allow all outbound traffic
  }

  outbound_rule {
    protocol = "udp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"] // Allow all outbound traffic
  }



}