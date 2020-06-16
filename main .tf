provider "google" {
  version = "3.5.0"

  credentials = file(var.credential)

  project = var.project
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Create VPC Network
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

# Create VM
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "n1-standard-1"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

# Create  Firewall Rules for SSH, Nginx and Kibana

resource "google_compute_firewall" "default" {
  name    = "apps-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22","80", "5601"]
  }

  target_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}



