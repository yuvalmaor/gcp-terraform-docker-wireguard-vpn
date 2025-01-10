variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM instance"
  type        = string
}

variable "image" {
  description = "Disk image for the VM"
  type        = string
}
