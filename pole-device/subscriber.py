import logging
from modules.mqtt import load_mqtt_config, load_mqtt_client

logging.basicConfig()
logger = logging.getLogger("mqtt")
logger.setLevel(logging.INFO)

def process_message(message):
    logger.info(f"Received message from `{message}`")

def run():
    config = load_mqtt_config()
    client = load_mqtt_client(config)
    client.connect_mqtt()
    client.subscribe(callback=process_message)

if __name__ == '__main__':
    run()
