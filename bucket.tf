resource "minio_s3_bucket" "buckets" {

  for_each = {
    for mount in var.buckets :
    mount.name => mount
  }

  bucket = each.value["name"]
  acl    = each.value["acl"]

}
