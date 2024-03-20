import os
import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client, load_mqtt_config_with_params, load_mqtt_client_with_params
from modules.config import get_period_configs

def build_message(msg_count: int, client_id: str):
    msg = build_crowd_flow_observed(msg_count=msg_count)
    msg["msg_count"] = msg_count
    msg["dateObservedTo"] = datetime.now().isoformat()
    msg["dateObservedFrom"] = datetime.now().isoformat()
    print(client_id + ": " + str(msg))
    return json.dumps(msg)

def build_crowd_flow_observed(msg_count: int):
    sensor_data = dict()
    part_period = int(os.getenv("PART_PERIOD"))
    full_period = int(os.getenv("FULL_PERIOD"))
    sensor_data["averageVehicleSpeed"] = generate_average_vehicle_speed(msg_count=msg_count, part_period=part_period, full_period=full_period)
    sensor_data["averageHeadwayTime"] = generate_average_headway_time(msg_count=msg_count, part_period=part_period, full_period=full_period)
    sensor_data["averageGapDistance"] = generate_average_gap_distance(msg_count=msg_count, part_period=part_period, full_period=full_period)
    sensor_data["averageVehicleLength"] = generate_average_vehicle_length(msg_count=msg_count, part_period=part_period, full_period=full_period)
    return sensor_data

# This method generates status based on the msg_count information
# 0 -> part_period -> full_period
def generate_average_vehicle_speed(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 10
    if (msg_count % full_period) > part_period:
        return 50

    return 10

def generate_average_headway_time(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 1
    if (msg_count % full_period) > part_period:
        return 5

    return 5

def generate_average_gap_distance(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 3
    if (msg_count % full_period) > part_period:
        return 50

    return 3

def generate_average_vehicle_length(msg_count, part_period, full_period):
    if full_period < part_period:
        raise Exception("full_period must be greater than part_period")
    
    if (msg_count % full_period) < part_period:
        return 200
    if (msg_count % full_period) > part_period:
        return 5

    return 200

def run():

    config = load_mqtt_config()
    client = load_mqtt_client(config)

    period_configs = get_period_configs()

    client.connect_mqtt()

    for period in period_configs:
        client.publish(n_messages=period.n_messages, message_period=period.message_period, callback=build_message)

    client.disconnect_mqtt()

def run_thread(broker_address: str, broker_port: str, client_id: str, username: str, password: str, broker_topic: str):
    config = load_mqtt_config_with_params(broker_address=broker_address, broker_port=broker_port, client_id=client_id, username=username, password=password)
    client = load_mqtt_client_with_params(config=config, broker_topic=broker_topic)

    period_configs = get_period_configs()

    client.connect_mqtt()

    for period in period_configs:
        client.publish(n_messages=period.n_messages, message_period=period.message_period, callback=build_message)

    client.disconnect_mqtt()

if __name__ == '__main__':
    run()
