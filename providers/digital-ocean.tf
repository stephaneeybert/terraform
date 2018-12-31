provider "digitalocean" {
  version = "~> 1.0"
  token   = "${var.DO_ACCESS_TOKEN}"
}
