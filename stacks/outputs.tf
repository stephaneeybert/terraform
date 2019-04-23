output "MASTER_IP" {
  value = "${module.kubernetes-master.K8S_MASTER_IPV4_ADDRESS}"
}

output "WORKER_1_IP" {
  value = "${module.kubernetes-worker-1.IPV4_ADDRESS}"
}
