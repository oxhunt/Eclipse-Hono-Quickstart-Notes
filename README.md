
Developed following the webpage: https://eclipse.dev/hono/docs/getting-started/

To replicate:
1) run the ```hono_registration.sh``` script to generate the hono.env file
2) You can now start the container using the dockerfile


Inside the devcontainer you can now open multiple shells and execute ```hono_consumer.sh``` and ```hono_xxxx_publisher.sh``` and see the messages produced by the publishers being outputted by the consumer.