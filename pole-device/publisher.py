import os
import json
from modules.mqtt import load_mqtt_config, load_mqtt_client

def build_message(msg_count: int):
    msg = {}
    msg["msg_count"] = msg_count
    msg["sensor"] = build_air_quality_observed()
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

def build_device_observed():
    sensor_data = dict()
    sensor_data["batteryLevel"] = 90
    sensor_data["dateObserved"] = "2023-07-01T01:11:34.39Z"
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
