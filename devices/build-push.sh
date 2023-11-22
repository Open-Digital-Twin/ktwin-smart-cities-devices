# Publisher devices

docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-air-quality-observed-device-publisher:0.1 --build-arg DEVICE_NAME=pole-air-quality-observed-device .
docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-weather-observed-device-publisher:0.1 --build-arg DEVICE_NAME=pole-weather-observed-device .
docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-crow-flow-observed-device-publisher:0.1 --build-arg DEVICE_NAME=pole-crow-flow-observed-device .
docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-noise-level-observed-device-publisher:0.1 --build-arg DEVICE_NAME=pole-noise-level-observed-device .
docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-streetlight-device-publisher:0.1 --build-arg DEVICE_NAME=streetlight-device .
docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-parking-spot-device-publisher:0.1 --build-arg DEVICE_NAME=parking-spot-device .
docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-ev-charging-device-publisher:0.1 --build-arg DEVICE_NAME=ev-charging-device .
docker buildx build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-battery-device-publisher:0.1 --build-arg DEVICE_NAME=battery-device .

docker push ghcr.io/open-digital-twin/ktwin-pole-air-quality-observed-device-publisher:0.1
docker ghcr.io/open-digital-twin/ktwin-pole-weather-observed-device-publisher:0.1
docker push ghcr.io/open-digital-twin/ktwin-pole-crow-flow-observed-device-publisher:0.1
docker push ghcr.io/open-digital-twin/ktwin-pole-noise-level-observed-device-publisher:0.1
docker push ghcr.io/open-digital-twin/ktwin-streetlight-device-publisher:0.1
docker push ghcr.io/open-digital-twin/ktwin-parking-spot-device-publisher:0.1
docker push ghcr.io/open-digital-twin/ktwin-ev-charging-device-publisher:0.1
docker push ghcr.io/open-digital-twin/ktwin-battery-device-publisher:0.1

# Subscriber devices
docker buildx build -f subscriber.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-air-quality-observed-device-subscriber:0.1 --build-arg DEVICE_NAME=pole-air-quality-observed-device .
docker buildx build -f subscriber.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-weather-observed-device-subscriber:0.1 --build-arg DEVICE_NAME=pole-weather-observed-device .
docker buildx build -f subscriber.Dockerfile  -t ghcr.io/open-digital-twin/ktwin-streetlight-device-subscriber:0.1 --build-arg DEVICE_NAME=streetlight-device .
docker buildx build -f subscriber.Dockerfile  -t ghcr.io/open-digital-twin/ktwin-parking-spot-device-subscriber:0.1 --build-arg DEVICE_NAME=parking-spot-device .
docker buildx build -f subscriber.Dockerfile  -t ghcr.io/open-digital-twin/ktwin-ev-charging-device-subscriber:0.1 --build-arg DEVICE_NAME=ev-charging-device .
docker buildx build -f subscriber.Dockerfile  -t ghcr.io/open-digital-twin/ktwin-battery-device-subscriber:0.1 --build-arg DEVICE_NAME=battery-device .

docker push ghcr.io/open-digital-twin/ktwin-pole-air-quality-observed-device-subscriber:0.1
docker ghcr.io/open-digital-twin/ktwin-pole-weather-observed-device-subscriber:0.1
docker push ghcr.io/open-digital-twin/ktwin-streetlight-device-subscriber:0.1
docker push ghcr.io/open-digital-twin/ktwin-parking-spot-device-subscriber:0.1
docker push ghcr.io/open-digital-twin/ktwin-ev-charging-device-subscriber:0.1
docker push ghcr.io/open-digital-twin/ktwin-battery-device-subscriber:0.1