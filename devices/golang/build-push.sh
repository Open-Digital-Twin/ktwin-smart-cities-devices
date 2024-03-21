# Publisher devices

docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-battery-device-publishers:0.1 --build-arg DEVICE_NAME=battery-device .

#docker push ghcr.io/open-digital-twin/ktwin-pole-air-quality-observed-device-publisher:0.1