resource "random_password" "db_pass" {
  length = 15
  special = true
  override_special = "_%@"
}

resource "kubernetes_secret" "chef"  {
  metadata {
    name = "chef"
    namespace = var.namespace
  }
  data = {
    POSTGRES_USER = "chef"
    POSTGRES_PASSWORD = random_password.db_pass.result
    CHEF_FQDN = local.chef_name
    POSTGRES_FQDN = local.db_name
    ES_FQDN = local.es_name
  }
}

