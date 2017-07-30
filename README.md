# Loom rsyslog relay Docker

## Run the container

```shell
docker run -e CUSTOMER_NAME=<cutomer name> [-e DEBUG=true] --privileged loomrelay
```

## Configuration with environment variables
* `CUSTOMER_NAME` - customer's name
* `DEBUG` [true|false] - start rsyslog with debug mode on (default is false)
