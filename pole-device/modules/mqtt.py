import logging
import time
import json
from paho.mqtt import client as paho_mqtt_client

QOS_AT_MOST_ONCE=0
QOS_AT_LEAST_ONCE=1
QOS_EXACTLY_ONCE=2

class MQTTClientConfig:
    def __init__(self, client_id, broker_address, port) -> None:
        self.has_credentials = False
        self.client_id = client_id
        self.broker_address = broker_address
        self.port = port
        self.username = None
        self.password = None
    
    def set_credentials(self, username, password):
        self.has_credentials = True
        self.username = username
        self.password = password

class MQTTClient:

    def __init__(self, config, topic) -> None:
        self.logger = logging.getLogger("mqtt")
        self.mqtt_config = config
        self.mqtt_client = paho_mqtt_client.Client(self.mqtt_config.client_id)
        self.topic = topic

        self.logger.info("MQTT Client %s created", self.mqtt_config.client_id)

    def connect_mqtt(self):
        def on_connect(client, userdata, flags, rc) -> None:
            if rc == 0:
                self.logger.info("Connected to MQTT Broker on topic %s", self.topic)
            else:
                self.logger.error("Failed to connect to topic %s, return code %d\n", self.topic, rc)

        self.mqtt_client.on_connect = on_connect

        if self.mqtt_config.has_credentials:
            self.mqtt_client.username_pw_set(self.mqtt_config.username, self.mqtt_config.password)

        self.mqtt_client.connect(self.mqtt_config.broker_address, self.mqtt_config.port)
        return self.mqtt_client
    
    def disconnect_mqtt(self):
        def on_disconnect():
            self.logger.info("Client disconnected")
        self.mqtt_client.disconnect(on_disconnect)

    # n_messages: total amount of messages
    # message_period: period of time between each message (seconds)
    # callback: function that returns the message to be sent
    # aliveMessage: it prints a alive message after N messages sent
    def publish(self, n_messages: int, message_period: float, callback, aliveMessage=100):
        msg_count = 0
        self.logger.info("Published to topic %s", self.topic)
        while n_messages > msg_count:
            time.sleep(message_period)
            msg = callback(msg_count)
            result = self.mqtt_client.publish(self.topic, msg)
            status = result[0]
            self.logger.info("Published to topic %s", self.topic)
            if status != 0:
                self.logger.error(f"Failed to send in client {self.mqtt_config.client_id} message to topic {self.topic}")
                self.logger.error(f"Failed to send `{msg}` to topic `{self.topic}`")
                self.logger.error(result)
            msg_count += 1
            if msg_count%aliveMessage:
                self.logger.info("Client %s still alive", self.mqtt_config.client_id)

    def subscribe(self, callback=None):
        def on_message(client, userdata, msg):
            msg_dict = json.loads(msg.payload)
            self.logger.info(f"Received message from `{msg_dict}`")
            if callback is not None:
                callback(msg_dict)

        self.mqtt_client.subscribe(self.topic)
        self.mqtt_client.on_message = on_message
        self.mqtt_client.loop_forever()