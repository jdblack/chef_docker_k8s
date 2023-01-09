# Overview

This container provides the cinc server API component for a scalable cinc
server clusters in Kubernetes.  We achieve that here by externalizing 
Postgres and replacing Solr with an external Elasticsearch cluster. Lastly,
we escrow the API server's  pivotal.pem and private-cinc-secrets within a 
kubernetes secret.

# Configuration

The following environment variables must be set for these containers:

CINC\_FQDN : The hostname by which clients will talk to the cinc server. This
will probably be the CNAME to the k8s load balancer that you put in front of
cinc.

POSTGRES\_USER : The name of the postgres admin user. A normal postgres account
is not typically sufficient, as cinc-server-reconfigure likes to do a lot of
admin things, like create databases, additional postgres accounts, templates,
and so on. In simpler words, give Chef a dedicated postgres server and let it
do what it wants.

POSTGRES\_PASSWORD : The password for the postgres admin account

POSTGRES\_FQDN : Where to reach the postgres user

SEARCH\_FQDN : The hostname of the opensearch cluster that cinc can use. This is the hostname. Supplying a port is not yet supported

SEARCH\_USER : The user on the opensearch cluster

SEARCH\_PASS : The user pass on opensearch

This dockerfile has numerous assumptions, including the assumption that
something is setting the following things up:

- A postgres database 
- An elasticsearch cluster
- A signed SSL cert for cinc


# How it works


