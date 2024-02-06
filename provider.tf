terraform {
  required_version = ">= 1.5.5"

  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = ">= 2.0.1"
    }
  }
}

provider "minio" {
  minio_server   = var.minio_server
  minio_region   = var.minio_region
  minio_user     = var.minio_user
  minio_password = var.minio_password
  minio_ssl      = var.minio_ssl
}

provider "helm" {
  # Several Kubernetes authentication methods are possible: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#authentication
  kubernetes {
    config_path = pathexpand(var.kube_config)
  }
}

provider "kubernetes" {
  config_path = pathexpand(var.kube_config)
}