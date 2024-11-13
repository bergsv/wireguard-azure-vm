variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "germanywestcentral"
}

variable "admin_password" {
  description = "The password for the admin user."
  default     = "changeme1234!"
}

variable "admin_username" {
  description = "The name for the admin user."
  default     = "adminuser"
}