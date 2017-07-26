sed -i "s/<CUSTOMER_NAME>/$CUSTOMER_NAME/g" /etc/rsyslog.d/10-loom.conf

if [ "$DEBUG" = false ]
then
  rsyslogd -n
else
  rsyslogd -dn
fi
