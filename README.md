# Loom rsyslog relay Docker

## Run the container

```shell
docker run --name <name> -e CUSTOMER_NAME=<cutomer name> [-e DEBUG=true] --privileged <name>

```

## Configuration with environment variables
* `CUSTOMER_NAME` - custumer's name
* `DEBUG` [true|false] - start rsyslog with debug mode on (default is false)
