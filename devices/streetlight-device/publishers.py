import os
import subprocess
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

processes = list()

for i in range(1, NUMBER_DEVICES):
    command = 'python publisher.py'
    env = load_env(i)
    print('Executing command: ' + command)

    process = subprocess.Popen(command, shell=True, env=env)
    processes.append(process)

for process in processes:
    process.wait()

print('All processes have finished')