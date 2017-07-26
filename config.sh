sed -i "s/<CUSTOMER_NAME>/$CUSTOMER_NAME/g" /etc/rsyslog.d/10-loom.conf
sed -i "s/<SEND_IP>/$SEND_IP/g" /etc/rsyslog.d/10-loom.conf

if [ -z "$CUSTOMER_NAME" ] || [ -z "$SEND_IP" ]
then
  echo "no customer name or sending ip  were specified"
  exit 1
fi

if [ "$DEBUG" = false ]
then
  rsyslogd -n
else
  rsyslogd -dn
fi
