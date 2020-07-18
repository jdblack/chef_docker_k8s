locals {
  chef_name = "chef"
  chef_port = 443
  chef_labels = {
    name = "chef"
  }
}

resource "kubernetes_deployment" "chef" {
  metadata {
    name = local.chef_name
    namespace = var.namespace
    labels = local.chef_labels
  }
  spec {
    replicas = 1

    selector { match_labels = local.chef_labels }

    template {
      metadata { labels = local.chef_labels }
      spec {
      automount_service_account_token = true
        container {
          name = local.chef_name
          image = "registry:5000/chef"
          port { container_port = local.chef_port }

          env {
            name = "NAMESPACE"
            value = var.namespace
          }

          env {
            name = "BACKEND_KEYS"
            value = "chef-backend-secrets"
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.chef.metadata.0.name
            }

          }
          volume_mount {
            name = "certs"
            mount_path = "/var/local/certs"
          }
        }
        image_pull_secrets {
          name = module.registry_access.registry_secret
        }
        volume {
          name = "certs"
          secret {
            secret_name = "server-cert"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "chef" {
  metadata {
    namespace = var.namespace
    name = local.chef_name
  }
  spec {
    type = "LoadBalancer"
    selector = local.chef_labels
    port {
      port        = local.chef_port
      target_port = local.chef_port
    }
  }
}
