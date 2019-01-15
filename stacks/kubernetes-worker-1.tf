module "droplet-worker-1" {
  #    source       = "git::https://github.com/stephaneeybert/terraform.git//modules/digitalocean/droplet"
  source          = "/home/stephane/dev/terraform/modules/digitalocean/droplet"
  SSH_PRIVATE_KEY = "${var.SSH_PRIVATE_KEY}"
  SSH_FINGERPRINT = "${var.SSH_FINGERPRINT}"
  DO_DROPLET_NAME = "kubernetes-worker-1"
}

module "kubernetes-worker-1" {
  #  source       = "git::https://github.com/stephaneeybert/terraform.git//modules/kubernetes/worker"
  source                  = "/home/stephane/dev/terraform/modules/kubernetes/worker"
  SSH_PRIVATE_KEY         = "${var.SSH_PRIVATE_KEY}"
  SSH_FINGERPRINT         = "${var.SSH_FINGERPRINT}"
  IPV4_ADDRESS            = "${module.droplet-worker-1.IPV4_ADDRESS}"
  K8S_MASTER_IPV4_ADDRESS = "${module.kubernetes-master.K8S_MASTER_IPV4_ADDRESS}"
  K8S_WORKER_NAME         = "kubernetes-worker-1"
  K8S_TOKEN               = "${var.K8S_TOKEN}"
}
