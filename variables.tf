variable "minio_region" {
  description = "Default MINIO region"
  default     = "eu-central-1"
  type        = string
}

variable "minio_ssl" {
  description = "MINIO SSL"
  default     = false
  type        = bool
}

variable "minio_server" {
  description = "Default MINIO host and port"
  type        = string
  default     = false
}

variable "minio_user" {
  description = "MINIO user"
  type        = string
}

variable "minio_password" {
  description = "MINIO password"
  type        = string
}

#####################################
### VARIABLES FOR BUCKET CREATION ###
#####################################

variable "buckets" {
  type = list(object({
    name = string
    acl  = string
  }))
  default     = []
  description = "A list of bucket"
}

###################################
### VARIABLES FOR USER CREATION ###
###################################

variable "users" {
  type = list(object({
    name   = string
    secret = string
    policy = string
  }))
  default     = []
  description = "A list of new users"
}

#####################################
### VARIABLES FOR POLICY CREATION ###
#####################################

variable "new_policy" {
  type = list(object({
    name   = string
    policy = string
  }))
  description = "Policy for creation"
  default     = []
}

##########################################
### VARIABLES FOR MINIO K8S DEPLOYMENT ###
##########################################

variable "ingress_class" {
  type    = string
  default = "nginx"
}

variable "enable_tls" {
  type    = bool
  default = true
}

variable "enable_deployment" {
  type    = bool
  default = false
}

variable "minio_image_repository" {
  type    = string
  default = "stuttgart-things/sthings-minio"
}

variable "minio_image_tag" {
  type    = string
  default = "13.3.3"
}

variable "minio_image_registry" {
  type    = string
  default = "eu.gcr.io"
}

variable "helm_chart" {
  type    = string
  default = "minio"
}

variable "helm_chart_version" {
  type    = string
  default = "13.3.3"
}

variable "helm_repository" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "namespace" {
  type    = string
  default = "minio"
}

variable "helm_release_name" {
  type    = string
  default = "minio"
}

variable "enable_storage" {
  type    = bool
  default = true
}

variable "storage_class" {
  type    = string
  default = false
}

variable "ingress_hostname_api" {
  type    = string
  default = false
}

variable "ingress_hostname_console" {
  type    = string
  default = false
}

variable "ingress_domain" {
  type    = string
  default = false
}

#########################################
### EXTRA VARIABLES FOR CERT CREATION ###
#########################################

variable "create_cert" {
  type    = bool
  default = false
}

variable "cluster_issuer" {
  type    = string
  default = ""
}
