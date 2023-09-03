output "instance_public_ip" {
  description = "The public IP address of the Compute Engine instance"
  value       = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}

output "instance_image_id" {
  description = "The image ID of the Compute Engine instance"
  value       = google_compute_instance.web_server.boot_disk[0].initialize_params[0].image
}

output "instance_type" {
  description = "The instance type of the Compute Engine instance"
  value       = google_compute_instance.web_server.machine_type
}

output "instance_network" {
  description = "The name of the custom VPC network"
  value       = google_compute_network.custom_network.name
}

output "instance_subnet" {
  description = "The name of the custom subnet"
  value       = google_compute_subnetwork.custom_subnet.name
}

output "instance_zone" {
  description = "The availability zone of the Compute Engine instance"
  value       = google_compute_instance.web_server.zone
}
