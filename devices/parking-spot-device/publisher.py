import os
import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client

def build_message(msg_count: int):
    msg = build_parkingspot_message(msg_count)
    msg["msg_count"] = msg_count
    msg["timestamp"] = datetime.now().isoformat()
    print(msg)
    return json.dumps(msg)

def build_parkingspot_message(msg_count):
    sensor_data = dict()
    part_period = int(os.getenv("PART_PERIOD"))
    full_period = int(os.getenv("FULL_PERIOD"))
    status = generate_status(msg_count=msg_count, part_period=part_period, full_period=full_period)
    sensor_data["status"] = status
    return sensor_data

# This method generates status based on the msg_count information
# 0 -> part_period -> full_period: it changes the status to occupied when message count is equal to N, later it changes to free when msg_count is M.
def generate_status(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("M must be greater than N")
    
    if (msg_count % full_period) < part_period:
        return "off"
    if (msg_count % full_period) > part_period:
        return "on"

    return "off"



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
