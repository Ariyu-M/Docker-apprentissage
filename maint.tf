terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Définir l'image Docker
resource "docker_image" "web_app_image" {
  name = "web_app_image"

  build {
    context = "/Bureau/Work/Formation/Cour/Exo-Terraform/FirstTime"
  }
}

# Définir le volume Docker
resource "docker_volume" "app_data" {
  name = "app_data_volume"
}

# Définir le conteneur Docker 1
resource "docker_container" "web_app" {
  name  = "web_app_instance_1"
  image = docker_image.web_app_image.name
}

# Définir le conteneur Docker 2
resource "docker_container" "web_app_2" {
  name  = "web_app_instance_2"
  image = docker_image.web_app_image.name
}

# Outputs pour obtenir les adresses IP des conteneurs
output "web_app_instance_1_address" {
  value = docker_container.web_app.network_data[0].ip_address
}

output "web_app_instance_2_address" {
  value = docker_container.web_app_2.network_data[0].ip_address
}
