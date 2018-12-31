variable "DO_DROPLET_NAME" {}
variable "SSH_FINGERPRINT" {}
variable "SSH_PRIVATE_KEY" {}

variable "DO_INSTANCE_TYPE" {
  type        = "string"
  default     = "ubuntu-18-04-x64"
  description = "The type of OS on the server"
}

variable "DO_INSTANCE_SIZE" {
  type        = "string"
  default     = "1gb"
  description = "The size of the memory of the server"
}
