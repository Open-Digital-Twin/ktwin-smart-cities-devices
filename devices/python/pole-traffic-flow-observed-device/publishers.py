import os
import threading
from publisher import run_thread
from dotenv import load_dotenv

def load_env(deviceNumber):
    env = os.environ.copy()
    env["BROKER_TOPIC"] = os.getenv("BROKER_TOPIC_{}".format(deviceNumber))
    env["CLIENT_ID"] = os.getenv("CLIENT_ID_{}".format(deviceNumber))
    return env

if os.getenv("ENV") == "publishers-local":
    load_dotenv('publishers-local.env')

NUMBER_DEVICES = int(os.getenv("NUMBER_DEVICES"))

print("Number of devices: " + str(NUMBER_DEVICES))

threads = list()

for i in range(0, NUMBER_DEVICES):
    broker_address = os.getenv("BROKER_ADDRESS")
    broker_port = int(os.getenv("BROKER_PORT"))
    client_id = os.getenv("CLIENT_ID")
    username = os.getenv("USERNAME")
    password = os.getenv("PASSWORD")
    broker_topic = os.getenv("BROKER_TOPIC_{}".format(i))
    client_id = os.getenv("CLIENT_ID_{}".format(i))

    args=[
        broker_address,
        broker_port,
        client_id,
        username,
        password,
        broker_topic
    ]

    thread = threading.Thread(name=client_id, target=run_thread, args=args)
    threads.append(thread)

for thread in threads:
    print('Starting Thread: ' + thread.name)
    thread.start()

for thread in threads:
    thread.join()

print('All processes have finished')