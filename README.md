# stuttgart-things/s3-minio-config

Terraform module for setting up and configure a minio s3 server instance.

## EXAMPLE MODULE USAGE

<details><summary>CREATE USERS</summary>

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

<details><summary>CREATE BUCKETS</summary>

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

<details><summary>CREATE POLICIES</summary>

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
  description = "Policy for creation"
}

```

```hcl
# VARIABLES -tfvars
minio_server   = "<MINIO_SERVER>"
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

```hcl
# VARIABLES -tfvars
minio_server   = "artifacts.app.4sthings.tiab.ssc.sva.de:443"
minio_user = "<USER>"
minio_password = "<PASSWORD>"

enable_deployment = true

namespace = "minio"
deployment_name = "minio-deployment"

ingress_hostname_api = "artifacts"
ingress_hostname_console = "artifacts-console"
ingress_domain = "app.4sthings.tiab.ssc.sva.de"
cluster_issuer = "cluster-issuer-approle"

enable_storage = true
storage_class = ""
```

</details>

<details><summary>DEPLOYMENT SERVER-INSTANCE</summary>

```hcl
# CALL MODULE - main.tf
module "s3-minio-config" {
  source                   = "github.com/stuttgart-things/s3-minio-config"
  enable_deployment        = true
  kube_config              = "/home/sthings/.kube/labda-dev7"
  namespace                = "minio"
  minio_region             = "eu-central-1"
  minio_ssl                = true
  minio_image_tag          = "13.3.3"
  enable_storage           = true
  helm_chart_version       = "13.3.3"
  ingress_hostname_api     = "artifacts"
  ingress_hostname_console = "artifacts-console"
  ingress_domain           = "dev7.4sthings.tiab.ssc.sva.de"
  minio_user               = "admin"
  minio_password           = "superSecret"
  ingress_class            = "nginx"
}
```

To create api and console certificates for the deployment include the following variables:

```hcl
# CALL MODULE - main.tf
module "s3-minio-config" {
...
cluster_issuer = "cluster-issuer-approle"
create_cert = true
...
}
```

</details>

<details><summary>CREATE MULTIPLE-RESOURCES (USER + BUCKETS + POLICY WITHIN DEPLOYMENT SERVER-INSTANCE)</summary>

```hcl
# CALL MODULE - main.tf
# main.tf
module "s3-minio-config" {
  source         = "github.com/stuttgart-things/s3-minio-config"
  minio_user     = "admin"
  minio_password = "superSecret"
  minio_server   = "artifacts.dev11.4sthings.tiab.ssc.sva.de"
  minio_region   = "eu-central-1"
  minio_ssl      = true

  ############
  ## TFVARS ##
  ############
  users          = var.users
  buckets        = var.buckets
  new_policy     = var.new_policy

  ################
  ## Deploy K8s ##
  ################
  enable_deployment        = true
  namespace                = "minio"
  minio_image_tag          = "13.3.3"
  enable_storage           = true
  helm_chart_version       = "13.3.3"
  ingress_hostname_api     = "artifacts"
  ingress_hostname_console = "artifacts-console"
  ingress_domain           = "dev11.4sthings.tiab.ssc.sva.de"
  ingress_class            = "nginx"
  create_cert              = true
  cluster_issuer           = "cluster-issuer-approle"
}


variable "users" {
  description = "A list of new users"
}

variable "buckets" {
  description = "A list of buckets"
}

variable "new_policy" {
  description = "Policy for creation"
}

```

```hcl
# VARIABLES -tfvars
users = [
  {
    name = "patrick"
    secret = null               # Randomly generated secret key
    policy = null               # No policy is attatched
  },
  {
    name = "hermann"
    secret = "thepassword"
    policy = "test_policy"
  }
]

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

new_policy = [
    {
        name = "test_policy"
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
```

</details>

## EXECUTION

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
Ana Calva, stuttgart-things 01/2024
Patrick Hermann, stuttgart-things 12/2023
```

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
