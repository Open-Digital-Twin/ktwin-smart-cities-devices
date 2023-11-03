import os
import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client

def build_message(msg_count: int):
    msg = build_weather_observed()
    msg["msg_count"] = msg_count
    msg["timestamp"] = datetime.now().isoformat()
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
