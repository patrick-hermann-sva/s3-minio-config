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

variable "buckets" {
  type = list(object({
    name = string
    acl  = string
  }))
  default     = []
  description = "A list of bucket"
}

variable "users" {
  type = list(object({
    name = string
  }))
  default = []
  description = "A list of new users"
}