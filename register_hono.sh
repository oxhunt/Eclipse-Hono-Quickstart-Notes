#!/bin/bash
# This script creates an hono.env file containing the
# registration details of a device to the hono sandbox



# initialization information
REGISTRY_IP=hono.eclipseprojects.io
HTTP_ADAPTER_IP=hono.eclipseprojects.io
MQTT_ADAPTER_IP=hono.eclipseprojects.io
KAFKA_IP=hono.eclipseprojects.io
APP_OPTIONS="-H hono.eclipseprojects.io -P 9094 --ca-file /etc/ssl/certs/ca-certificates.crt -u hono -p hono-secret"
CURL_OPTIONS=
MOSQUITTO_OPTIONS='--cafile /etc/ssl/certs/ca-certificates.crt'
MY_PWD=this-is-my-password

# creating a new tenant
MY_TENANT=$(curl -i -X POST ${CURL_OPTIONS} -H "content-type: application/json" --data-binary '{
  "ext": {
    "messaging-type": "kafka"
  }
}' https://${REGISTRY_IP}:28443/v1/tenants |
grep id | cut -c8- | rev | cut -c3- | rev
)

# adding a device to the tenant
MY_DEVICE=$(
    curl -i -X POST ${CURL_OPTIONS} https://${REGISTRY_IP}:28443/v1/devices/${MY_TENANT} |
    grep id | cut -c8- | rev | cut -c3- | rev
)

# Set Password for the device
curl -i -X PUT ${CURL_OPTIONS} -H "content-type: application/json" --data-binary '[{
  "type": "hashed-password",
  "auth-id": "'${MY_DEVICE}'",
  "secrets": [{
      "pwd-plain": "'${MY_PWD}'"
  }]
}]' https://${REGISTRY_IP}:28443/v1/credentials/${MY_TENANT}/${MY_DEVICE}

cat <<EOS > hono.env
export REGISTRY_IP="$REGISTRY_IP"
export HTTP_ADAPTER_IP="$HTTP_ADAPTER_IP"
export MQTT_ADAPTER_IP="$MQTT_ADAPTER_IP"
export KAFKA_IP="$KAFKA_IP"
export APP_OPTIONS="$APP_OPTIONS"
export CURL_OPTIONS="$CURL_OPTIONS"
export MOSQUITTO_OPTIONS="$MOSQUITTO_OPTIONS"
export MY_PWD="$MY_PWD"
export MY_TENANT="$MY_TENANT"
export MY_DEVICE="$MY_DEVICE"
EOS