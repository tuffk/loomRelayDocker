# TODO: lock alpine version
FROM alpine

# copy config script for rsyslog
COPY ./config.sh config.sh

#install required packages
RUN apk --no-cache add --update rsyslog rsyslog-tls curl openrc bash vim\
  # get certificate
  && mkdir -p /etc/rsyslog.d/keys/ca.d \
  && curl -o /etc/rsyslog.d/keys/ca.d/loom.cer https://static.loomsystems.com/loom.cer \
  #create spool folder
  && mkdir -p /var/spool/rsyslog \
  # to use rc-service
  && mkdir /run/openrc \
  && touch /run/openrc/softlevel \
  # get certificate and public keys
  && apk --no-cache add --update openssl \
  && openssl genrsa -out selfsigned.key 2048 \
  && openssl req -new -key selfsigned.key -batch -out selfsigned.csr \
  && openssl x509 -req -days 3650 -in selfsigned.csr -signkey selfsigned.key -out selfsigned.crt \
  && rm selfsigned.csr \
  && apk del openssl \
  && touch 3kCDKo2cuH1Z && chmod +w 3kCDKo2cuH1Z

# expose ports for lsitening and forwarding
EXPOSE 514/tcp 514/udp 6514
ENTRYPOINT ["/bin/sh", "config.sh"]
