# Publishers devices

docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-air-quality-observed-device-publishers:0.1 --build-arg DEVICE_NAME=pole-air-quality-observed-device .
docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-weather-observed-device-publishers:0.1 --build-arg DEVICE_NAME=pole-weather-observed-device .
docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-crowd-flow-observed-device-publishers:0.1 --build-arg DEVICE_NAME=pole-crowd-flow-observed-device .
docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-traffic-flow-observed-device-publishers:0.1 --build-arg DEVICE_NAME=pole-traffic-flow-observed-device .
docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-noise-level-observed-device-publishers:0.1 --build-arg DEVICE_NAME=pole-noise-level-observed-device .
docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-streetlight-device-publishers:0.1 --build-arg DEVICE_NAME=streetlight-device .
docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-parking-spot-device-publishers:0.1 --build-arg DEVICE_NAME=parking-spot-device .
docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-ev-charging-device-publishers:0.1 --build-arg DEVICE_NAME=ev-charging-device .
docker buildx build -f publishers.Dockerfile -t ghcr.io/open-digital-twin/ktwin-battery-device-publishers:0.1 --build-arg DEVICE_NAME=battery-device .

docker push ghcr.io/open-digital-twin/ktwin-pole-air-quality-observed-device-publishers:0.1
docker push ghcr.io/open-digital-twin/ktwin-pole-weather-observed-device-publishers:0.1
docker push ghcr.io/open-digital-twin/ktwin-pole-crowd-flow-observed-device-publishers:0.1
docker push ghcr.io/open-digital-twin/ktwin-pole-traffic-flow-observed-device-publishers:0.1
docker push ghcr.io/open-digital-twin/ktwin-pole-noise-level-observed-device-publishers:0.1
docker push ghcr.io/open-digital-twin/ktwin-streetlight-device-publishers:0.1
docker push ghcr.io/open-digital-twin/ktwin-parking-spot-device-publishers:0.1
docker push ghcr.io/open-digital-twin/ktwin-ev-charging-device-publishers:0.1
docker push ghcr.io/open-digital-twin/ktwin-battery-device-publishers:0.1
