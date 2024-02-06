resource "helm_release" "minio" {
  count = var.enableMinioDeployment == true ? 1 : 0

  name  = var.deployment_name
  chart = "bitnami/minio"
  namespace = var.namespace

  values = [
    templatefile("${path.module}/templates/minio-values.tpl", {
      helmStorageEnabled = var.helmStorageEnabled
      storageClass = var.storageClass

      INGRESS_HOSTNAME_API = var.ingress_hostname_api
      INGRESS_HOSTNAME_CONSOLE = var.ingress_hostname_console
      INGRESS_DOMAIN = var.ingress_domain
      CLUSTER_ISSUER = var.cluster_issuer

      MINIO_ADMIN_USER = var.minio_user
      MINIO_ADMIN_PASSWORD = var.minio_password
    })
  ]

}