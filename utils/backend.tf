# The "backend" is the interface that Terraform uses to store state

terraform {
  backend "consul" {
    address = "demo.consul.io"
    path    = "getting-started-kjfriuerjrefreufjrefure"
    lock    = false
  }
}
