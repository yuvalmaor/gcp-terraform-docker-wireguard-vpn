variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM instance"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet to attach the VM"
  type        = string
}


variable "private_subnet_name" {
  description = "Name of the subnet to attach the VM"
  type        = string
}

variable "region" {
  description = "Region where the VM will be deployed"
  type        = string
}

variable "image" {
  description = "Disk image for the VM"
  type        = string
}
