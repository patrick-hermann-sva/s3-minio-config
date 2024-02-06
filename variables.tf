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
### Variables for bucket creation ###
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
### Variables for user creation ###
###################################

variable "users" {
  type = list(object({
    name = string
    secret = string
    policy = string
  }))
  default = []
  description = "A list of new users"
}

#####################################
### Variables for policy creation ###
#####################################

variable "new_policy" {
  type = list(object({
    name = string
    policy = string
  }))
  description = "Policy for creation"
  default = []
}

##########################################
### Variables for minio k8s deployment ###
##########################################

variable "enableMinioDeployment" {
  type    = bool
  default = false
}

variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "namespace" {
  type    = string
  default = ""
}

variable "deployment_name" {
  type    = string
  default = ""
}

variable "helmStorageEnabled" {
  type    = bool
  default = true
}

variable "storageClass" {
  type    = string
  default = ""
}

variable "ingress_hostname_api" {
  type    = string
  default = ""
}

variable "ingress_hostname_console" {
  type    = string
  default = ""
}

variable "ingress_domain" {
  type    = string
  default = ""
}

variable "cluster_issuer" {
  type    = string
  default = ""
}

