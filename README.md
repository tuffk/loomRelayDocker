# Loom rsyslog relay Docker

## Run the container

```shell
docker run --name <name> -e CUSTOMER_NAME=<cutomer name> -e SEND_IP=<send ip> --privileged <name>

```

## Configuration with environment variables
* `SEND_IP` - ip to send the logs
* `CUSTOMER_NAME` - custumer's name
