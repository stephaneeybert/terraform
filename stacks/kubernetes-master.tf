module "droplet-master" {
  #    source       = "git::https://github.com/stephaneeybert/terraform.git//modules/digitalocean/droplet"
  source          = "/home/stephane/dev/terraform/modules/digitalocean/droplet"
  SSH_FINGERPRINT = "${var.SSH_FINGERPRINT}"
  SSH_PRIVATE_KEY = "${var.SSH_PRIVATE_KEY}"
  DO_DROPLET_NAME = "kubernetes-master"
}

module "kubernetes-master" {
  #  source       = "git::https://github.com/stephaneeybert/terraform.git//modules/kubernetes/master"
  source          = "/home/stephane/dev/terraform/modules/kubernetes/master"
  SSH_PRIVATE_KEY = "${var.SSH_PRIVATE_KEY}"
  IPV4_ADDRESS    = "${module.droplet-master.IPV4_ADDRESS}"
  K8S_TOKEN       = "${var.K8S_TOKEN}"
}
