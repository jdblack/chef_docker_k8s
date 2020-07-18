# I use a private registry for my stuff. This module sets up 
# access to my private registry. All that really does is it sets up 
# a k8s secret that gives k8s deployments the credentials they need to pull
# from a private registry

module "registry_access"  {
  source =  "../registry_access"
  namespace = var.namespace
  registry_auth = var.registry_auth
}

