resource "null_resource" "kubernetes-worker" {
  provisioner "local-exec" {
    command = "echo Worker node ${var.K8S_WORKER_NAME} has IP ${var.IPV4_ADDRESS}"
  }

  provisioner "local-exec" {
    command = "echo Worker node ${var.K8S_WORKER_NAME} has K8S_TOKEN ${var.K8S_TOKEN}"
  }

  connection {
    host        = "${var.IPV4_ADDRESS}"
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.SSH_PRIVATE_KEY)}"
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/kubernetes-bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "kubeadm join '${var.K8S_MASTER_IPV4_ADDRESS}:6443' --token '${var.K8S_TOKEN}' --discovery-token-unsafe-skip-ca-verification",
    ]
  }
}
