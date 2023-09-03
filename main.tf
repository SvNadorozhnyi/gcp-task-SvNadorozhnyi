provider "google" {
  credentials = file("../cred/terra-project-397916-df2ca523fe88.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}

resource "google_compute_network" "custom_network" {
  name = var.network_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "custom_subnet" {
  name          = var.subnet_name
  network       = google_compute_network.custom_network.name
  region        = var.region
  ip_cidr_range = var.subnet_cidr
}

resource "google_compute_firewall" "web_server_ingress_firewall" {
  name    = "ingress-rule"
  network = google_compute_network.custom_network.name
 
  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "web_server_egress_firewall" {
  name = "egress-rule"
  network = google_compute_network.custom_network.name

  allow {
    protocol = "tcp"
    ports    = []
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "EGRESS"
}

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

  metadata_startup_script = <<-SCRIPT
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    systemctl start apache2
    systemctl enable apache2
  SCRIPT

  network_interface {
    network = google_compute_network.custom_network.name
    subnetwork = google_compute_subnetwork.custom_subnet.name
    access_config {

    }
  }
}
