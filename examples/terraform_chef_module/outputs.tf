
output "lb" {
  value = kubernetes_service.chef.load_balancer_ingress.0.ip
}
