provider "google" {
  credentials = file("../cred/terra-project-397916-df2ca523fe88.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}

# Create a custom VPC network
resource "google_compute_network" "custom_network" {
  name = var.network_name
}

# Create a custom subnet within the custom VPC
resource "google_compute_subnetwork" "custom_subnet" {
  name          = var.subnet_name
  network       = google_compute_network.custom_network.name
  ip_cidr_range = var.subnet_cidr
}

# Create a Compute Engine instance
resource "google_compute_instance" "web_server" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone
  tags         = var.network_tags

  boot_disk {
    initialize_params {
      image = var.image_family
    }
  }

  network_interface {
    network = google_compute_network.custom_network.name
    subnetwork = google_compute_subnetwork.custom_subnet.name
    access_config {
      // This block configures a public IP address
    }
  }
  metadata_startup_script = file("apache-install.sh")
}
