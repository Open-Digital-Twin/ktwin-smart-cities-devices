FROM python:alpine3.18

ARG DEVICE_NAME

COPY ./DEVICE_NAME /app

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT [ "python", "publisher.py" ]
