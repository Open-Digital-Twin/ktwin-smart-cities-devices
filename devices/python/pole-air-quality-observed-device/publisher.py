import os
import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client, load_mqtt_config_with_params, load_mqtt_client_with_params
from modules.config import get_period_configs

def build_message(msg_count: int, client_id: str):
    msg = build_air_quality_observed()
    msg["msg_count"] = msg_count
    msg["timestamp"] = datetime.now().isoformat()
    print(client_id + ": " + str(msg))
    return json.dumps(msg)

def build_air_quality_observed() -> dict:
    sensor_data = dict()
    sensor_data["reliability"] = 8
    sensor_data["volatileOrganicCompoundsTotal"] = 0
    sensor_data["CO2Density"] = 8
    sensor_data["CODensity"] = 8
    sensor_data["PM1Density"] = 8
    sensor_data["PM10Density"] = 8
    sensor_data["PM25Density"] = 8
    sensor_data["SO2Density"] = 8
    sensor_data["C6H6Density"] = 8
    sensor_data["NIDensity"] = 8
    sensor_data["NODensity"] = 8
    sensor_data["ASDensity"] = 8
    sensor_data["CDDensity"] = 8
    sensor_data["NO2Density"] = 8
    sensor_data["O3Density"] = 8
    sensor_data["PBDensity"] = 8
    sensor_data["SH2Density"] = 8
    sensor_data["precipitation"] = 8
    sensor_data["temperature"] = 8
    sensor_data["WindDirection"] = 8
    sensor_data["WindSpeed"] = 8
    sensor_data["relativeHumidity"] =  8
    return sensor_data

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
