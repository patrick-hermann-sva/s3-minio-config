terraform {
  required_version = ">= 1.5.5"

  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = ">= 2.0.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">=2.12.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.25.2"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">=1.14.0"
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
  kubernetes {
    config_path = pathexpand(var.kube_config)
  }
}

provider "kubernetes" {
  config_path = pathexpand(var.kube_config)
}

provider "kubectl" {
  config_path = pathexpand(var.kube_config)
}