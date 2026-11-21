variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "germanywestcentral"
}

variable "admin_username" {
  description = "The name for the admin user."
  default     = "adminuser"
}

variable "admin_password" {
  description = "The password for the admin user. There is no default on purpose, choose your own."
  type        = string
  sensitive   = true
}

variable "ssh_source_address" {
  description = "Public IP address or CIDR range that may reach the VM over SSH during setup, for example 203.0.113.10/32."
  type        = string
}
