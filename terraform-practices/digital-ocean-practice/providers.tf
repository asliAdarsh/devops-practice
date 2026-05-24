
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {}

moved {
  from = digitalocean_vpc.custom_vpc
  to   = module.development_cluster.digitalocean_vpc.custom_vpc
}

moved {
  from = digitalocean_droplet.web_server
  to   = module.development_cluster.digitalocean_droplet.web_server
}

moved {
  from = digitalocean_firewall.web_firewall
  to   = module.development_cluster.digitalocean_firewall.web_firewall
}