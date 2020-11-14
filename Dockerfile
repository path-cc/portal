
ARG IMAGE_BASE_TAG=fresh

FROM opensciencegrid/software-base:$IMAGE_BASE_TAG

LABEL maintainer OSG Software <support@opensciencegrid.org>

RUN \
    yum update -y && \
    yum install -y python3-pip httpd mod_auth_openidc && \
    yum clean all && rm -rf /var/cache/yum/*

COPY registry run_local.sh requirements.txt /opt/registry/
RUN pip3 install -r /opt/registry/requirements.txt

COPY register.py /usr/bin
COPY supervisor-apache.conf /etc/supervisord.d/40-apache.conf
COPY examples/apache.conf /etc/httpd/conf.d/

ENV CONFIG_DIR=/srv
#ENTRYPOINT ["/opt/registry/run_local.sh"]
#CMD ["--host=0.0.0.0"]
