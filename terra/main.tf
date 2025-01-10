provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source      = "./modules/network"
  network_name = var.network_name
  region       = var.region
}

module "compute" {
  source        = "./modules/compute"
  instance_name = var.instance_name
  machine_type  = var.machine_type
  subnet_name   = module.network.public_subnet
  private_subnet_name = module.network.private_subnet
  region        = var.region
  image         = var.image
}
