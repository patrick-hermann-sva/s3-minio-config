image:
  registry: ${MINIO_IMAGE_REGISTRY}
  repository: ${MINIO_IMAGE_REPOSITORY}
  tag: ${MINIO_IMAGE_TAG}

networkPolicy:
  enabled: true
  allowExternal: true

auth:
  rootUser: ${MINIO_ADMIN_USER}
  rootPassword: ${MINIO_ADMIN_PASSWORD}

ingress:
  enabled: true
  ingressClassName: ${INGRESS_CLASS}
  tls: true
  extraTls:
    - hosts:
        - ${INGRESS_HOSTNAME_CONSOLE}.${INGRESS_DOMAIN}
      secretName: ${INGRESS_HOSTNAME_CONSOLE}-ingress-tls
  hostname: ${INGRESS_HOSTNAME_CONSOLE}.${INGRESS_DOMAIN}

apiIngress:
  enabled: true
  ingressClassName: ${INGRESS_CLASS}
  tls: ${ENABLE_TLS}
  extraTls:
    - hosts:
        - ${INGRESS_HOSTNAME_API}.${INGRESS_DOMAIN}
      secretName: ${INGRESS_HOSTNAME_API}-ingress-tls
  hostname: ${INGRESS_HOSTNAME_API}.${INGRESS_DOMAIN}

persistence:
  enabled: ${ENABLE_STORAGE}
  storage_class: ${STORAGE_CLASS}

extraEnvVars:
  - name: MINIO_SERVER_URL
    value: https://${INGRESS_HOSTNAME_API}.${INGRESS_DOMAIN}
  - name: MINIO_BROWSER_REDIRECT_URL
    value: https://${INGRESS_HOSTNAME_CONSOLE}.${INGRESS_DOMAIN}:9001
