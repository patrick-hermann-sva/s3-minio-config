data "kubectl_path_documents" "certs" {
    pattern = "${path.module}/templates/*.yaml.tpl"
    vars = {
        INGRESS_HOSTNAME = format("%s,%s",var.ingress_hostname_api,var.ingress_hostname_console)
        INGRESS_DOMAIN = var.ingress_domain
        CLUSTER_ISSUER = var.cluster_issuer
        NAMESPACE = var.namespace
        NAME = var.helm_release_name
    }
}

resource "kubectl_manifest" "cert_manifest" {
    count = var.create_cert == true ? length(data.kubectl_path_documents.certs.documents) : 0
    yaml_body = element(data.kubectl_path_documents.certs.documents, count.index)
}
