resource "null_resource" "kubernetes-master" {
  provisioner "local-exec" {
    command = "echo Master node has IP ${var.IPV4_ADDRESS}"
  }

  provisioner "local-exec" {
    command = "echo Master node has K8S_TOKEN ${var.K8S_TOKEN}"
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
      "kubeadm init --token '${var.K8S_TOKEN}' --apiserver-advertise-address=${var.IPV4_ADDRESS} --pod-network-cidr=192.168.1.0/16 --ignore-preflight-errors=all",
      "export TF_JOIN_COMMAND=\"`kubeadm token create --print-join-command`\"",
    ]
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/sign-ssh-csr.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "mkdir -p /root/.kube",
      "sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config",
      "sudo chown $(id -u):$(id -g) /root/.kube/config",
      "export KUBECONFIG=/etc/kubernetes/admin.conf",
    ]
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/create-namespace.sh"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/create-role-deployment-manager.yml"
    destination = "/tmp/create-role-deployment-manager.yml"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/create-role-binding-deployment-manager.yml"
    destination = "/tmp/create-role-binding-deployment-manager.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "kubectl create -f /tmp/create-role-deployment-manager.yml",
      "kubectl create -f /tmp/create-role-binding-deployment-manager.yml",
    ]
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/configure-cluster.sh"

    environment {
      MASTER_IP = "${var.IPV4_ADDRESS}"
    }
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/configure-user.sh"

    environment {
      MASTER_IP = "${var.IPV4_ADDRESS}"
    }
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/configure-kubectl.sh"

    environment {
      MASTER_IP = "${var.IPV4_ADDRESS}"
    }
  }
}
