locals {
  es_name = "elasticsearch"
  es_port = 9200
  es_labels = {
    name = "elasticsearch"
  }
}

resource "kubernetes_deployment" "es" {
  metadata {
    name = local.es_name
    namespace = var.namespace
    labels = local.es_labels
  }
  spec {
    replicas = 1

    selector { match_labels = local.es_labels }

    template {
      metadata { labels = local.es_labels }
      spec {
        automount_service_account_token = true
        container {
          name = local.es_name
          image = "docker.elastic.co/elasticsearch/elasticsearch:5.6.16"
          port { container_port = local.es_port }
          env {
            name = "discovery.type"
            value = "single-node"
          }
          env {
            name = "xpack.security.enabled"
            value = false
          }
        }

      }
    }
  }
}

resource "kubernetes_service" "elasticsearch" {
  metadata {
    namespace = var.namespace
    name = local.es_name
  }
  spec {
    selector = local.es_labels
    port {
      port        = local.es_port
      target_port = local.es_port
    }
  }
}
