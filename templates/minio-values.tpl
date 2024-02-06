image:
  registry: eu.gcr.io
  repository: stuttgart-things/sthings-minio
  tag: 13.3.3

networkPolicy:
  enabled: true
  allowExternal: true

auth:
  rootUser: ${MINIO_ADMIN_USER}
  rootPassword: ${MINIO_ADMIN_PASSWORD}

ingress:
  enabled: true
  ingressClassName: nginx
  tls: true
  extraTls:
    - hosts:
        - ${INGRESS_HOSTNAME_CONSOLE}.${INGRESS_DOMAIN}
      secretName: ${INGRESS_HOSTNAME_CONSOLE}-ingress-tls
  hostname: ${INGRESS_HOSTNAME_CONSOLE}.${INGRESS_DOMAIN}

apiIngress:
  enabled: true
  ingressClassName: "nginx"
  tls: true
  extraTls:
    - hosts:
        - ${INGRESS_HOSTNAME_API}.${INGRESS_DOMAIN}
      secretName: ${INGRESS_HOSTNAME_API}-ingress-tls
  hostname: ${INGRESS_HOSTNAME_API}.${INGRESS_DOMAIN}

persistence:
  enabled: ${helmStorageEnabled}
  storageClass: ${storageClass}

extraEnvVars:
  - name: MINIO_SERVER_URL
    value: https://${INGRESS_HOSTNAME_API}.${INGRESS_DOMAIN}
  - name: MINIO_BROWSER_REDIRECT_URL
    value: https://${INGRESS_HOSTNAME_CONSOLE}.${INGRESS_DOMAIN}:9001
