resource "google_compute_network" "network" {
  name = var.network_name

}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.network.id
  region        = var.region
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.network.id
  region        = var.region
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.network.name

  allow {
    protocol = "tcp"
    ports    = ["22","80","443","51820"]
  }

  direction = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_vpn" {
  name    = "allow-vpn"
  network = google_compute_network.network.name

  allow {
    protocol = "udp"
    ports    = ["51820"]
  }

  direction = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
}



resource "google_compute_firewall" "allow_subnet_traffic" {
  name    = "allow-subnet-traffic"
  network = google_compute_network.network.name

  allow {
    protocol = "all" # or specific protocols like "tcp"
    ports    = []    # Allow all ports or specify as needed
  }

  direction    = "INGRESS"
  source_ranges = ["10.0.1.0/24", "10.0.2.0/24"]
  target_tags   = ["subnet-access"]
}

