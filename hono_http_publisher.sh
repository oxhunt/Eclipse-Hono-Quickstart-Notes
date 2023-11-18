#!/bin/bash
# this application keeps publishing a temperature message
source hono.env
for ((TEMPERATURE=-10; TEMPERATURE<=60; TEMPERATURE++)); do
    # publishing telemetry
    curl -i -u ${MY_DEVICE}@${MY_TENANT}:${MY_PWD} ${CURL_OPTIONS} -H 'Content-Type: application/json' --data-binary '{"temp": $TEMPERATURE}' https://${HTTP_ADAPTER_IP}:8443/telemetry
    sleep 2
    # publishing an event
    curl -i -u ${MY_DEVICE}@${MY_TENANT}:${MY_PWD} ${CURL_OPTIONS} -H 'Content-Type: application/json' --data-binary '{"alarm": "fire"}' https://${HTTP_ADAPTER_IP}:8443/event
done