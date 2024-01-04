terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
        version = "3.0.2"
    }
  }
}

resource "docker_image" "k3s_img" {
  name = "rancher/k3s"
}

resource "docker_container" "k3s" {
  image = docker_image.k3s_img.image_id
  name = "k3s"
  ports {
    external = 6443
    internal = 6443
  }
  volumes {
    container_path = "/var/kubedata"
    host_path = "C:\\Personal\\Programming-Files\\Distributed-Systems-Demos\\kubecfg"
  }
  env = [ "K3S_TOKEN=abcdef" ]
  privileged = true
  command = [ "server" ]
}