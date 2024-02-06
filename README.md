# stuttgart-things/s3-minio-config

terraform module for base-setup configuration of minio s3

## EXAMPLE USAGE

<details><summary>EXAMPLE-USECASE #1: CREATE USERS ONLY</summary>

```hcl
# CALL MODULE - main.tf
module "s3-minio-config" {
  source         = "github.com/stuttgart-things/s3-minio-config" # OR LOCAL E.G. "../s3-minio-config"
  minio_user     = var.minio_user
  minio_server   = var.minio_server
  minio_password = var.minio_password
  minio_region   = var.minio_region
  minio_ssl      = true
  users          = var.users
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

variable "users" {
  type = list(object({
    name = string
    secret = string
    policy = string
  }))
  default = []
  description = "A list of new users"
}

output "user_minio_user" {
    value = module.s3-minio-config.user_minio_user
}

output "minio_user_secret" {
    value = module.s3-minio-config.minio_user_secret
}

output "minio_user_status" {
    value = module.s3-minio-config.minio_user_status
}

```

```hcl
# VARIABLES -tfvars
minio_server   = "artifacts.app.4sthings.tiab.ssc.sva.de:443"
users = [
  {
    name = "patrick"
    secret = null               # Randomly generated secret key
    policy = null               # No policy is attatched
  },
  {
    name = "hermann"
    secret = "thepassword"
    policy = "readwrite"
  }
]
minio_user = "<USER>"
minio_password = "<PASSWORD>"

```

</details>

<details><summary>EXAMPLE-USECASE #2: CREATE BUCKETS ONLY</summary>

```hcl
# CALL MODULE - main.tf
module "s3-minio-config" {
  source         = "github.com/stuttgart-things/s3-minio-config"
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
```hcl
# VARIABLES -tfvars
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
minio_user = "<USER>"
minio_password = "<PASSWORD>"

```

</details>

<details><summary>EXAMPLE-USECASE #3: CREATE POLICY ONLY</summary>

```hcl
# CALL MODULE - main.tf
module "s3-minio-config" {
  source         = "github.com/stuttgart-things/s3-minio-config"
  minio_user     = var.minio_user
  minio_server   = var.minio_server
  minio_password = var.minio_password
  minio_region   = var.minio_region
  minio_ssl      = true
  new_policy     = var.new_policy
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

variable "new_policy" {
  type = list(object({
    name = string
    policy = string
  }))
  description = "Policy for creation"
  default = []
}

```

```hcl
# VARIABLES -tfvars
minio_server   = "artifacts.app.4sthings.tiab.ssc.sva.de:443"
new_policy = [
    {
        name = "test_policy_1"
        policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
       {
          "Effect": "Allow",
          "Action": [
             "s3:ListAllMyBuckets"
          ],
          "Resource": [
             "arn:aws:s3:::*"
          ]
       }
    ]
 }
        EOF
    },
]
minio_user = "<USER>"
minio_password = "<PASSWORD>"
```

</details>

<details><summary>EXAMPLE-USECASE #4: DEPLOY MINIO IN K8S</summary>

```hcl
# CALL MODULE - main.tf
module "s3-minio-config" {
  source         = "github.com/stuttgart-things/s3-minio-config"
  minio_user     = var.minio_user
  minio_server   = var.minio_server
  minio_password = var.minio_password
  minio_region   = var.minio_region
  minio_ssl      = true
  enableMinioDeployment = var.enableMinioDeployment
  namespace             = var.namespace
  deployment_name       = var.deployment_name
  ingress_hostname_api  = var.ingress_hostname_api
  ingress_domain        = var.ingress_domain
  cluster_issuer        = var.cluster_issuer
  ingress_hostname_console = var.ingress_hostname_console
  helmStorageEnabled    = var.helmStorageEnabled
  storageClass          = var.storageClass
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

variable "enableMinioDeployment" {      
  type    = bool
  default = false 
}

variable "namespace" {
  type    = string
  default = "minio"
}

variable "deployment_name" {
  type    = string
  default = "minio-deployment"
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
  default = "artifacts"
}

variable "ingress_hostname_console" {
  type    = string
  default = "artifacts-console"
}

variable "ingress_domain" {
  type    = string
  default = "app.4sthings.tiab.ssc.sva.de"
}

variable "cluster_issuer" {
  type    = string
  default = "cluster-issuer-approle"
}


```

```hcl
# VARIABLES -tfvars
minio_server   = "artifacts.app.4sthings.tiab.ssc.sva.de:443"
minio_user = "<USER>"
minio_password = "<PASSWORD>"

enableMinioDeployment = true

namespace = "minio"
deployment_name = "minio-deployment"

ingress_hostname_api = "artifacts"
ingress_hostname_console = "artifacts-console"
ingress_domain = "app.4sthings.tiab.ssc.sva.de"
cluster_issuer = "cluster-issuer-approle"

helmStorageEnabled = true
storageClass = ""
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
