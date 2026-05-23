output "server_public_ip" {
  value       = digitalocean_droplet.web_server.ipv4_address
  description = "The public IP address of our web server droplet"
}
