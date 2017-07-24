SENDING_IP=${SENDING_IP:=$SEND_IP}
CUST_NAME=${CUST_NAME:=$CUSTOMER_NAME}

echo "# uncommend for TCP input. Note that you might need to change the port if it is already in use
module(load=\"imtcp\") # needs to be done just once
input(type=\"imtcp\" port=\"514\")

# UDP input
module(load=\"imudp\") # needs to be done just once
input(type=\"imudp\" port=\"514\")

\$ActionSendStreamDriver gtls

\$DefaultNetstreamDriverCAFile /etc/rsyslog.d/keys/ca.d/loom.cer
\$DefaultNetstreamDriverCertFile /selfsigned.crt
\$DefaultNetstreamDriverKeyFile /selfsigned.key

\$ActionSendStreamDriverAuthMode x509/name
\$ActionSendStreamDriverPermittedPeer *.loomsystems.com
\$ActionSendStreamDriverMode 1

\$WorkDirectory /var/spool/rsyslog # where to place spool files
\$ActionQueueFileName fwdRule1     # unique name prefix for spool files
\$ActionQueueMaxDiskSpace 1g       # 1gb space limit (use as much as possible)
\$ActionQueueSaveOnShutdown on     # save messages to disk on shutdown
\$ActionQueueType LinkedList       # run asynchronously
\$ActionResumeRetryCount -1        # infinite retries if host is down

# forward then drop the relayed messages" >> /etc/rsyslog.d/10-loom.conf
#echo "action(type=\"omfwd\" Target=\"$SENDING_IP\" Port=\"6514\" Protocol=\"tcp\" Device=\"eth0\")" >> /etc/rsyslog.d/10-loom.conf
echo "*.* @@$CUST_NAME-data.loomsystems.com:6514" >> /etc/rsyslog.d/10-loom.conf

touch 3kCDKo2cuH1Z
rsyslogd -n
