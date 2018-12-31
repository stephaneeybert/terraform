resource "digitalocean_droplet" "droplet" {
  image              = "${var.DO_INSTANCE_TYPE}"
  name               = "${var.DO_DROPLET_NAME}"
  region             = "fra1"
  size               = "${var.DO_INSTANCE_SIZE}"
  private_networking = true

  ssh_keys = [
    "${var.SSH_FINGERPRINT}",
  ]

  connection {
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.SSH_PRIVATE_KEY)}"
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/create-ssh-key-and-csr.sh"
  }
}
