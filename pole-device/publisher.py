import os
import json
import logging
import random
import sys
from dotenv import load_dotenv
from modules.mqtt import MQTTClient, MQTTClientConfig

def load_mqtt_config() -> MQTTClientConfig:
    if os.getenv("ENV") == "local":
        load_dotenv('local.env')

    broker_address = os.getenv("BROKER_ADDRESS")
    broker_port = int(os.getenv("BROKER_PORT"))
    client_id = os.getenv("CLIENT_ID")
    username = os.getenv("USERNAME")
    password = os.getenv("PASSWORD")

    config = MQTTClientConfig(broker_address=broker_address, client_id=client_id, port=broker_port)
    
    if username is not None and password is not None:
        config.set_credentials(username=username, password=password)

    return config

def load_mqtt_client(config: MQTTClientConfig) -> MQTTClient:
    broker_topic = os.getenv("BROKER_TOPIC")
    client = MQTTClient(config=config, topic=broker_topic)
    return client

def build_message(msg_count: int):
    msg = {}
    msg["msg_count"] = msg_count
    msg["sensor"] = build_sensor_data()
    return json.dumps(msg)

def build_sensor_data():
    sensor_data = dict()
    sensor_data["type"] = 1
    sensor_data["air_temperature"] = 10
    sensor_data["process_temperature"] = 10
    sensor_data["rotational_speed"] = 10
    sensor_data["torque"] = 10
    sensor_data["tool_wear"] = 5
    sensor_data["twf"] = 10
    sensor_data["hdf"] = 10
    sensor_data["pwf"] = 10
    sensor_data["osf"] = 10
    sensor_data["rnf"] = 10
    return sensor_data

def run():

    config = load_mqtt_config()
    client = load_mqtt_client(config)

    if os.getenv("N_MESSAGES") == '':
        n_messages = 3
    else:
        n_messages = int(os.getenv("N_MESSAGES"))

    if os.getenv("MESSAGE_PERIOD") == '':
        message_period = 1
    else:
        message_period = float(os.getenv("MESSAGE_PERIOD"))

    client.connect_mqtt()
    client.publish(n_messages=n_messages, message_period=message_period, callback=build_message)
    client.disconnect_mqtt()

if __name__ == '__main__':
    run()
