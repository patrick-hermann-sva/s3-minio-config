resource "minio_iam_policy" "new_policy" {
  for_each = {
    for mount in var.new_policy :
    mount.name => mount
  }

  name   = each.value["name"]
  policy = each.value["policy"]

  depends_on = [helm_release.minio]
}