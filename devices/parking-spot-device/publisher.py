import os
import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client
from modules.config import get_period_configs

def build_message(msg_count: int, client_id: str):
    msg = build_parkingspot_message(msg_count)
    msg["msg_count"] = msg_count
    msg["timestamp"] = datetime.now().isoformat()
    print(client_id + ": " + str(msg))
    return json.dumps(msg)

def build_parkingspot_message(msg_count):
    sensor_data = dict()
    part_period = int(os.getenv("PART_PERIOD"))
    full_period = int(os.getenv("FULL_PERIOD"))
    status = generate_status(msg_count=msg_count, part_period=part_period, full_period=full_period)
    sensor_data["status"] = status
    return sensor_data

# This method generates status based on the msg_count information
# 0 -> part_period -> full_period: it changes the status to free when message count is equal to part_period, later it changes to occupied when msg_count is full_period.
def generate_status(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return "free"
    if (msg_count % full_period) > part_period:
        return "occupied"

    return "free"


def run():
    config = load_mqtt_config()
    client = load_mqtt_client(config)

    period_configs = get_period_configs()

    for period in period_configs:
        client.connect_mqtt()
        client.publish(n_messages=period.n_messages, message_period=period.message_period, callback=build_message)
        client.disconnect_mqtt()

if __name__ == '__main__':
    run()
