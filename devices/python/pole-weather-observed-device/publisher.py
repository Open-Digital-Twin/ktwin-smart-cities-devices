import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client, load_mqtt_config_with_params, load_mqtt_client_with_params
from modules.config import get_period_configs

def build_message(msg_count: int, client_id: str):
    msg = build_weather_observed()
    msg["msg_count"] = msg_count
    msg["timestamp"] = datetime.now().isoformat()
    print(client_id + ": " + str(msg))
    return json.dumps(msg)

def build_weather_observed():
    sensor_data = dict()
    sensor_data["atmosphericPressure"] = 10
    sensor_data["dewpoint"] = 8
    sensor_data["temperature"] = 8
    sensor_data["illuminance"] = 8
    sensor_data["precipitation"] = 8
    sensor_data["relativeHumidity"] = 8
    sensor_data["snowHeight"] = 8
    sensor_data["solarRadiation"] = 8
    sensor_data["streamGauge"] = 8
    sensor_data["uVIndexMax"] = 8
    sensor_data["visibility"] = 8
    sensor_data["WindDirection"] = 8
    sensor_data["WindSpeed"] = 8
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
