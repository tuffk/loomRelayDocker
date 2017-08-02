if [ -z "$CUSTOMER_NAME" ]
then
  echo "Error starting relay: please specify your customer name"
  exit 1
fi

if [[ $(dig $CUSTOMER_NAME-data.loomsystems.com +short | wc -l) -lt 1 ]]
then
  echo "Error starting relay: invalid or nonexistent customer receiver"
  exit 2
fi

nc -zv $CUSTOMER_NAME-data.loomsystems.com 6514
if [[ $? -ne 0 ]]
then
 echo "Error starting relay: port 6514 on the receiver is unreachable"
 exit 3
fi

sed -i "s/<CUSTOMER_NAME>/$CUSTOMER_NAME/g" /etc/rsyslog.d/10-loom.conf
sed -i "s/<SENDING_IP>/$SENDING_IP/g" /etc/rsyslog.d/10-loom.conf

if [ "$DEBUG" = false ]
then
  rsyslogd -n
else
  rsyslogd -dn
fi
