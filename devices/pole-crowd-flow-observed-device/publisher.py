import os
import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client
from modules.config import get_period_configs

def build_message(msg_count: int):
    msg = build_crowd_flow_observed()
    msg["msg_count"] = msg_count
    msg["dateObservedTo"] = datetime.now().isoformat()
    msg["dateObservedFrom"] = datetime.now().isoformat()
    return json.dumps(msg)

def build_crowd_flow_observed(msg_count: int):
    sensor_data = dict()
    part_period = int(os.getenv("PART_PERIOD"))
    full_period = int(os.getenv("FULL_PERIOD"))
    sensor_data["averageCrowdSpeed"] = generate_average_crowd_speed(msg_count=msg_count, part_period=part_period, full_period=full_period)
    sensor_data["averageHeadwayTime"] = generate_average_headway_time(msg_count=msg_count, part_period=part_period, full_period=full_period)
    sensor_data["peopleCount"] = generate_average_people_count(msg_count=msg_count, part_period=part_period, full_period=full_period)
    return sensor_data

# This method generates status based on the msg_count information
# 0 -> part_period -> full_period
def generate_average_crowd_speed(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 2
    if (msg_count % full_period) > part_period:
        return 8

    return 2

def generate_average_headway_time(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 1
    if (msg_count % full_period) > part_period:
        return 6

    return 2

def generate_average_people_count(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 50
    if (msg_count % full_period) > part_period:
        return 5

    return 2

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
