#!/bin/bash
source hono.env
# in directory where the hono-cli-*-exec.jar file has been downloaded to
./hono-cli-2.4.1 app ${APP_OPTIONS} consume --tenant ${MY_TENANT}