# stuttgart-things/s3-minio-config

terraform module for base-setup configuration of minio s3

## EXAMPLE USAGE

<details><summary>CALL MODULE</summary>

```hcl
# main.tf
module "s3-minio-config" {
  source         = "github.com/stuttgart-things/s3-minio-config" # OR LOCAL E.G. "../s3-minio-config"
  minio_user     = var.minio_user
  minio_server   = var.minio_server
  minio_password = var.minio_password
  minio_region   = var.minio_region
  minio_ssl      = true
  buckets        = var.buckets
}

variable "minio_region" {
  description = "Default MINIO region"
  default     = "eu-central-1"
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
  description = "A list of buckets"
}
```

</details>

<details><summary>EXAMPLE TFVARS</summary>

```hcl
# terraform.tfvars
minio_server   = "artifacts.app.4sthings.tiab.ssc.sva.de:443"
buckets = [
  {
    name = "data"
    acl  = "public"
  },
  {
    name = "backup"
    acl  = "public"
  }
]

```
</details>

<details><summary>EXECUTE TERRAFORM</summary>

```bash
export TF_VAR_minio_user="<ACCESS-ID>"
export TF_VAR_minio_password="<SECRET-ACCESS-ID>"

terraform init
terraform validate
terraform plan
terraform apply
```

</details>

## DEV

<details><summary>TASKS</summary>

```bash
task: Available tasks for this project:

* branch:       Create branch from main
* commit:       Commit + push code into branch
* pr:           Create pull request into main
```

</details>



## Author Information

```bash
Patrick Hermann, stuttgart-things 12/2023
```

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
