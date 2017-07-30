sed -i "s/<CUSTOMER_NAME>/$CUSTOMER_NAME/g" /etc/rsyslog.d/10-loom.conf
sed -i "s/<SEND_IP>/$SEND_IP/g" /etc/rsyslog.d/10-loom.conf

if [ -z "$CUSTOMER_NAME" ] || [ -z "$SEND_IP" ]
then
  echo "Error starting relay: please specify your customer name"
  exit 1
fi

if [ "$DEBUG" = false ]
then
  rsyslogd -n
else
  rsyslogd -dn
fi
