FROM ubuntu:14.04

RUN apt-get update && apt-get install -yq wget && apt-get clean

# We want chef, of course
RUN wget https://packages.chef.io/files/stable/chef-server/12.19.31/ubuntu/14.04/chef-server-core_12.19.31-1_amd64.deb -O chef.deb  && dpkg -i chef.deb && rm chef.deb

# We use the k8s-client gem to save pivotal.pem to the chef secret in k8s
RUN apt install build-essential -qy && \
    /opt/opscode/embedded/bin/gem  install k8s-client  && \
    apt purge build-essential -yq && \
    apt-get autoremove -qy 

RUN rm -rf /var/lib/apt

COPY files/* /opt/docker/
RUN ln -sf /opt/docker/chef-server.rb /etc/opscode
CMD ["/opt/docker/init"]

