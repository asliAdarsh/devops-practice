module "dev-network" {
  source = "./modules/network_layer"
  env_name = "devlopment"
  ip_range = "10.0.0.0/16"
  region = "blr1"
  firewall_name = "devlopment-firewall"
}
module "prod-network" {
  source = "./modules/network_layer"
  env_name = "production"
  ip_range = "10.1.0.0/16"
  region = "blr1"
  firewall_name = "prod-firewall"
}

module "dev-cluster_1"{
  source = "./modules/app_cluster"
  droplet_name = "dev-web-1"
  region = "blr1"
  droplet_size = "s-1vcpu-1gb"
  vpc_id = module.dev-network.vpc_id
  tags = ["devlopment"]
}
module "dev-cluster_2"{
  source = "./modules/app_cluster"
  droplet_name = "dev-web-2"
  region = "blr1"
  droplet_size = "s-1vcpu-1gb"
  vpc_id = module.dev-network.vpc_id
  tags = ["devlopment"]
}

module "prod-cluster_1"{
  source = "./modules/app_cluster"
  droplet_name = "prod-web-1"
  region = "blr1"
  droplet_size = "s-1vcpu-1gb"
  vpc_id = module.prod-network.vpc_id
  tags = ["production"]
}