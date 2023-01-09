FROM ubuntu:22.04
RUN echo "Etc/UTC" > /etc/timezone

RUN apt-get update && apt-get install -yq wget iproute2 systemctl  anacron
RUN DEBIAN_FRONTEND=noninteractive apt install tzdata locales 

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8



# We want cinc, of course
RUN wget http://downloads.cinc.sh/files/stable/cinc-server/15.3.2/ubuntu/22.04/cinc-server-core_15.3.2-1_amd64.deb -O cinc_server.deb  && dpkg -i cinc_server.deb && rm cinc_server.deb

CMD "/bin/sh"
# We use the k8s-client gem to save pivotal.pem to the chef secret in k8s
RUN apt install build-essential -qy && \
    /opt/cinc-project/embedded/bin/gem  install k8s-client  && \
    apt purge build-essential -yq && \
    apt-get autoremove -qy 

RUN rm -rf /var/lib/apt

COPY files/* /opt/docker/
RUN ln -sf /opt/docker/cinc-server.rb /etc/cinc-project
CMD ["/opt/docker/init"]

