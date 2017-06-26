FROM nginx:latest

MAINTAINER Roman Naumenko (roman@naumenko.ca)

ENV CONSUL_TEMPLATE_VERSION=0.18.5

RUN apt-get update && apt-get install -y unzip curl

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /

RUN unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip  && \
    mv /consul-template /usr/local/bin/consul-template && \
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

RUN mkdir -p /consul-template/template.d

ADD template/ /consul-template/template.d/
ADD template/nginx.conf /etc/nginx/
ADD errors/ /consul-template/error.d/
ADD launch.sh /consul-template/launch.sh
ADD reload_nginx.sh /consul-template/
RUN chmod 775 /consul-template/*.sh

# nginx ingress port
EXPOSE 9999 
EXPOSE 80

CMD ["/consul-template/launch.sh"]
