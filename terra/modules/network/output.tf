output "public_subnet" {
  value = google_compute_subnetwork.public_subnet.name
}

output "private_subnet" {
  value = google_compute_subnetwork.private_subnet.name
}
