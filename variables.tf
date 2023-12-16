variable "minio_region" {
  description = "Default MINIO region"
  default     = "eu-central-1"
}

variable "minio_ssl" {
  description = "MINIO SSL"
  default     = false
}

variable "minio_server" {
  description = "Default MINIO host and port"
}

variable "minio_user" {
  description = "MINIO user"
}

variable "minio_password" {
  description = "MINIO password"
}

variable "buckets" {
  type = list(object({
    name = string
    acl  = string
  }))
  default     = []
  description = "A list of bucket"
}