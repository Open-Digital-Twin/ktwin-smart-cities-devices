import logging
import random
from modules.mqtt import MQTTClient, MQTTClientConfig

logging.basicConfig()
logger = logging.getLogger("mqtt")
logger.setLevel(logging.INFO)

broker_address = 'localhost'
port = 1883
topic = "mytopic"
client_id = f'python-mqtt-{random.randint(0, 100)}'
username = None
password = None

def run():
    config = MQTTClientConfig(client_id=client_id, broker_address=broker_address, port=port)

    if username is not None and password is not None:
        config.set_credentials(username=username,password=password)

    client = MQTTClient(config=config, topic=topic)
    client.connect_mqtt()
    client.subscribe()

if __name__ == '__main__':
    run()
