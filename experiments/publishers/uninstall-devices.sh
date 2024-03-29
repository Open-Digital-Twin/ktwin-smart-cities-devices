
# Values shared between all instances are in values.yaml
# Values specific for each instance is passed as parameter

# ############################
# ## EV Charging Devices
# ############################

NUMBER_NEIGHBORHOOD=5

DEVICE_NAME=ev-charging-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    helm uninstall $DEVICE_NAME-$neighborhood
done

############################
## Off street Parking Spot Devices
############################

DEVICE_NAME=parking-spot-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    helm uninstall $DEVICE_NAME-$neighborhood
done

############################
## Pole Air Quality Observed Devices
############################

DEVICE_NAME=pole-air-quality-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    helm uninstall $DEVICE_NAME-$neighborhood
done

############################
## Pole Weather Observed Devices
############################

DEVICE_NAME=pole-weather-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    helm uninstall $DEVICE_NAME-$neighborhood
done

############################
## Pole Noise Level Observed Devices
############################

DEVICE_NAME=pole-noise-level-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    helm uninstall $DEVICE_NAME-$neighborhood
done

############################
## Pole Crowd Level Observed Devices
############################

DEVICE_NAME=pole-crowd-flow-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    helm uninstall $DEVICE_NAME-$neighborhood
done

############################
## Pole Traffic Level Observed Devices
############################

DEVICE_NAME=pole-traffic-flow-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    helm uninstall $DEVICE_NAME-$neighborhood
done

############################
## Streetlight Devices
############################

DEVICE_NAME=streetlight-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    helm uninstall $DEVICE_NAME-$neighborhood
done