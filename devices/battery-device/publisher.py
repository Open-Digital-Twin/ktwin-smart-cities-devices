import os
import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client

def build_message(msg_count: int):
    msg = build_battery_message(msg_count)
    msg["msg_count"] = msg_count
    msg["timestamp"] = datetime.now().isoformat()
    print(msg)
    return json.dumps(msg)

def build_battery_message(msg_count):
    sensor_data = dict()
    part_period = int(os.getenv("PART_PERIOD"))
    full_period = int(os.getenv("FULL_PERIOD"))
    sensor_data["batteryLevel"] = generate_power_state(msg_count=msg_count, part_period=part_period, full_period=full_period)
    return sensor_data

# This method generates status based on the msg_count information
# 0 -> part_period -> full_period: it changes the batteryLevel when message count is equal to part_period, later it changes to a different value when msg_count is full_period.
def generate_power_state(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 90
    if (msg_count % full_period) > part_period:
        return 15

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
