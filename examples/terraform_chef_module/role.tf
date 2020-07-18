# The api server needs the ability to create k8s secrets, giving it
# The ability to pass on the pivotal.pem and private-chef-secrets.json
# To other api servers.

resource "kubernetes_role" "chef" {
  metadata {
    namespace = var.namespace
    name = local.chef_name
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    verbs          = ["get", "create", "update", "patch"]
  }
}

resource "kubernetes_role_binding" "chef" {
  metadata {
    name      = local.chef_name
    namespace = var.namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = local.chef_name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = var.namespace
  }
}

