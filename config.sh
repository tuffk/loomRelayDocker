SENDING_IP=${SENDING_IP:=$SEND_IP}
CUST_NAME=${CUST_NAME:=$CUSTOMER_NAME}
sed -i "s/<CUSTOMER_NAME>/$CUSTOMER_NAME/g" /etc/rsyslog.d/10-loom.conf
touch 3kCDKo2cuH1Z
rsyslogd -n