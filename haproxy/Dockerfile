FROM haproxy:1.6

MAINTAINER Roman Naumenko (roman@naumenko.ca)

ENV CONSUL_TEMPLATE_VERSION=0.16.0

RUN apt-get update && apt-get install -y unzip curl

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /

RUN unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip  && \
    mv /consul-template /usr/local/bin/consul-template && \
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

RUN mkdir -p /consul-template/template.d

ADD template/ /consul-template/template.d/
ADD errors/ /consul-template/error.d/
ADD launch.sh /consul-template/launch.sh

# haproxy ingress port
EXPOSE 9999 
# haproxy stats
EXPOSE 1936 

CMD ["/consul-template/launch.sh"]