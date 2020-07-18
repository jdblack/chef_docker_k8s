# Overview

This container provides the chef server API component for a scalable chef
server clusters in Kubernetes.  We achieve that here by externalizing 
Postgres and replacing Solr with an external Elasticsearch cluster. Lastly,
we escrow the API server's  pivotal.pem and private-chef-secrets within a 
kubernetes secret.

# Configuration

The following environment variables must be set for these containers:

CHEF_FQDN : The hostname by which clients will talk to the chef server. This
will probably be the CNAME to the k8s load balancer that you put in front of
chef.

POSTGRES_USER : The name of the postgres admin user. A normal postgres account
is not typically sufficient, as chef-server-reconfigure likes to do a lot of
admin things, like create databases, additional postgres accounts, templates,
and so on. In simpler words, give Chef a dedicated postgres server and let it
do what it wants.

POSTGRES_PASSWORD : The password for the postgres admin account

POSTGRES_FQDN : Where to reach the postgres user

ES_FQDN : The hostname of the elasticsearch cluster that chef can use. This is the hostname. Supplying a port is not yet supported

# Orchestration assumptions

# How it works

