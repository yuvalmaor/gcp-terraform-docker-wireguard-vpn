resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.subnet_name
    access_config {}
  }
  tags = ["subnet-access"]
  metadata = {
    ssh-keys = "yuvalnix305:${file("~/.ssh/id_rsa.pub")}"
    startup-script = file("${path.module}/startup.sh")
  }
}


resource "google_compute_instance" "vm_instance_private" {
  name         = "${var.instance_name}-p"
  machine_type = var.machine_type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.private_subnet_name
    access_config {}
  }
  tags = ["subnet-access"]
  metadata = {
    ssh-keys = "yuvalnix305:${file("~/.ssh/id_rsa.pub")}"
    startup-script = file("${path.module}/startup.sh")
  }
}
