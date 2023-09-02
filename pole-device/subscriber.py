import logging
from modules.mqtt import load_mqtt_config, load_mqtt_client

logging.basicConfig()
logger = logging.getLogger("mqtt")
logger.setLevel(logging.INFO)

def run():
    config = load_mqtt_config()
    client = load_mqtt_client(config)
    client.connect_mqtt()
    client.subscribe()

if __name__ == '__main__':
    run()
