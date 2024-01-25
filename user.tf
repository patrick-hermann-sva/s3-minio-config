resource "minio_iam_user" "minio_user" {
  for_each = {
    for mount in var.users :
    mount.name => mount
  }

  name = each.value["name"]
  secret = each.value["secret"]
}