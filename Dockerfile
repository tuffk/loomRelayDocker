FROM alpine:3.6

ENV DEBUG=false \
  CUSTOMER_NAME=""

#install required packages
RUN apk update \
  && apk upgrade \
  && apk --no-cache add --update rsyslog rsyslog-tls curl \
  && curl --create-dirs -o /etc/rsyslog.d/keys/ca.d/loom.pem https://static.loomsystems.com/loom.cer \
  && awk '{if(NR==1)sub(/^\xef\xbb\xbf/,"");print}' /etc/rsyslog.d/keys/ca.d/loom.pem > /etc/rsyslog.d/keys/ca.d/loom.pem \
  && mkdir -p /var/spool/rsyslog \
  && apk del curl

# copy config script for rsyslog
COPY ./config.sh config.sh
COPY ./10-loom.conf /etc/rsyslog.d/10-loom.conf

# expose ports for lsitening and forwarding
EXPOSE 514/tcp 514/udp 6514
ENTRYPOINT ["/bin/sh", "config.sh"]
