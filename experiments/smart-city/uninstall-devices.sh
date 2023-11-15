
# Values shared between all instances are in values.yaml
# Values specific for each instance is passed as parameter

NUMBER_DEVICES=2
DEVICE_NAME=battery-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    id=$(printf "%03d" $counter)
    helm uninstall $DEVICE_NAME-$id
done

NUMBER_DEVICES=2
DEVICE_NAME=ev-charging-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    id=$(printf "%03d" $counter)
    helm uninstall $DEVICE_NAME-$id
done

NUMBER_DEVICES=2
DEVICE_NAME=parking-spot-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    id=$(printf "%03d" $counter)
    helm uninstall $DEVICE_NAME-$id
done

NUMBER_DEVICES=2
DEVICE_NAME=pole-air-quality-observed-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    id=$(printf "%03d" $counter)
    helm uninstall $DEVICE_NAME-$id
done

NUMBER_DEVICES=2
DEVICE_NAME=pole-weather-observed-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    id=$(printf "%03d" $counter)
    helm uninstall $DEVICE_NAME-$id
done

NUMBER_DEVICES=2
DEVICE_NAME=streetlight-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    id=$(printf "%03d" $counter)
    helm uninstall $DEVICE_NAME-$id
done
