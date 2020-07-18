# The ssl_cert module referenced here uses Certificate manager to make a
# certificate That module uses certificate manager that creates a k8s secret
# named "server-cert" that has the following Data tls.crt, tls.key and ca.cert
#
# Not using certificate manager is perfectly acceptable, but you'll need
# Something to create that secret

module "ssl_cert" {
  source = "../server_cert"
  namespace = var.namespace
  name = "server-cert"
  cert_domains = var.domains
  issuer = var.cert_issuer
}

