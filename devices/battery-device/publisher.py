import os
import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client
from modules.config import get_period_configs

def build_message(msg_count: int, client_id: str):
    msg = build_battery_message(msg_count)
    msg["msg_count"] = msg_count
    msg["timestamp"] = datetime.now().isoformat()
    print(client_id + ": " + str(msg))
    return json.dumps(msg)

def build_battery_message(msg_count):
    sensor_data = dict()
    part_period = int(os.getenv("PART_PERIOD"))
    full_period = int(os.getenv("FULL_PERIOD"))
    sensor_data["batteryLevel"] = get_battery_level(msg_count=msg_count, part_period=part_period, full_period=full_period)
    sensor_data["measurementFrequency"] = get_measure_frequency_level(msg_count=msg_count, part_period=part_period+part_period/3, full_period=full_period+part_period/3)
    return sensor_data

# This method generates status based on the msg_count information
# 0 -> part_period -> full_period: it changes the batteryLevel when message count is equal to part_period, later it changes to a different value when msg_count is full_period.
def get_battery_level(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 90
    if (msg_count % full_period) > part_period:
        return 12

    return 90

# This method generates status based on the msg_count information
# 0 -> part_period -> full_period: it changes the measurementFrequency when message count is equal to part_period, later it changes to a different value when msg_count is full_period.
def get_measure_frequency_level(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 15
    if (msg_count % full_period) > part_period:
        return 60

    return 90

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
