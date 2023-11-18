#!/bin/bash
source hono.env
while [ 1 ]; do
    # publishing an event
    mosquitto_pub -h ${MQTT_ADAPTER_IP} -p 8883 -u ${MY_DEVICE}@${MY_TENANT} -P ${MY_PWD} ${MOSQUITTO_OPTIONS} -t event -q 1 -m '{"alarm": "fire"}'
    sleep 1
    # publishing telemetry
    mosquitto_pub -h ${MQTT_ADAPTER_IP} -p 8883 -u ${MY_DEVICE}@${MY_TENANT} -P ${MY_PWD} ${MOSQUITTO_OPTIONS} -t telemetry -m '{"telemetry": 5}'
    sleep 1
done