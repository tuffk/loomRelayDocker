sed -i "s/<CUSTOMER_NAME>/$CUSTOMER_NAME/g" /etc/rsyslog.d/10-loom.conf

if [ -z "$CUSTOMER_NAME" ]
then
  echo "no customer name was specified"
  exit "no customer name was specified"
fi

if [ "$DEBUG" = false ]
then
  rsyslogd -n
else
  rsyslogd -dn
fi
