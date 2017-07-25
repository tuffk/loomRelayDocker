# TODO: lock alpine version
FROM alpine

#install required packages
RUN apk update \
  && apk upgrade \
  && apk --no-cache add --update rsyslog rsyslog-tls curl bash gnutls openssl \
  # get certificate
  && curl --create-dirs -o /etc/rsyslog.d/keys/ca.d/loom.pem https://static.loomsystems.com/loom.cer \
  && awk '{if(NR==1)sub(/^\xef\xbb\xbf/,"");print}' /etc/rsyslog.d/keys/ca.d/loom.pem > /etc/rsyslog.d/keys/ca.d/loom.pem \
  && mkdir -p /var/spool/rsyslog \
  && openssl genrsa -out selfsigned.key 2048 \
  && openssl req -new -key selfsigned.key -batch -out selfsigned.csr \
  && openssl x509 -req -days 3650 -in selfsigned.csr -signkey selfsigned.key -out selfsigned.crt \
  && rm selfsigned.csr \
  && apk del openssl \
  && touch 3kCDKo2cuH1Z && chmod +w 3kCDKo2cuH1Z

# copy config script for rsyslog
COPY ./config.sh config.sh
COPY ./10-loom.conf /etc/rsyslog.d/10-loom.conf

# expose ports for lsitening and forwarding
EXPOSE 514/tcp 514/udp 6514
ENTRYPOINT ["/bin/sh", "config.sh"]