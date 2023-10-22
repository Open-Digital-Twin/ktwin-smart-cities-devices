FROM python:alpine3.18

ARG DEVICE_NAME

COPY ./${DEVICE_NAME}/modules /app/modules
COPY ./${DEVICE_NAME}/publisher.py /app/publisher.py
COPY ./${DEVICE_NAME}/requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT [ "python", "publisher.py" ]
