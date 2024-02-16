resource "helm_release" "minio" {
  count            = var.enable_deployment == true ? 1 : 0
  name             = var.helm_release_name
  version          = var.helm_chart_version
  chart            = var.helm_chart
  repository       = var.helm_repository
  create_namespace = var.create_namespace
  namespace        = var.namespace
  values = [
    templatefile("${path.module}/templates/minio-values.tpl", {
      MINIO_IMAGE_REGISTRY     = var.minio_image_registry
      MINIO_IMAGE_REPOSITORY   = var.minio_image_repository
      MINIO_IMAGE_TAG          = var.minio_image_tag
      ENABLE_STORAGE           = var.enable_storage
      ENABLE_TLS               = var.enable_tls
      STORAGE_CLASS            = var.storage_class
      INGRESS_HOSTNAME_API     = var.ingress_hostname_api
      INGRESS_HOSTNAME_CONSOLE = var.ingress_hostname_console
      INGRESS_DOMAIN           = var.ingress_domain
      INGRESS_CLASS            = var.ingress_class
      MINIO_ADMIN_USER         = var.minio_user
      MINIO_ADMIN_PASSWORD     = var.minio_password
    })
  ]
  depends_on = [kubectl_manifest.cert_manifest]
}
