import json
from datetime import datetime
from modules.mqtt import load_mqtt_config, load_mqtt_client
from modules.config import get_period_configs

def build_message(msg_count: int, client_id: str):
    msg = build_noise_level_observed()
    msg["msg_count"] = msg_count
    msg["timestamp"] = datetime.now().isoformat()
    print(client_id + ": " + str(msg))
    return json.dumps(msg)

def build_noise_level_observed():
    sensor_data = dict()
    sensor_data["LASSoundPressure"] = 10
    sensor_data["LAeqSoundPressure"] = 8
    sensor_data["LAeq_dSoundPressure"] = 8
    sensor_data["LAmaxSoundPressure"] = 8
    return sensor_data

def run():

    config = load_mqtt_config()
    client = load_mqtt_client(config)

    period_configs = get_period_configs()

    client.connect_mqtt()

    for period in period_configs:
        client.publish(n_messages=period.n_messages, message_period=period.message_period, callback=build_message)

    client.disconnect_mqtt()

if __name__ == '__main__':
    run()
