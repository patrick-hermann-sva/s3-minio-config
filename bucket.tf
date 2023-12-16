resource "minio_s3_bucket" "state_terraform_s3" {

  for_each = {
    for mount in var.buckets :
    mount.name => mount
  }

  bucket = each.value["name"]
  acl    = each.value["acl"]

}
