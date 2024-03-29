
# Values shared between all instances are in values.yaml
# Values specific for each instance is passed as parameter

# ############################
# ## EV Charging Devices
# ############################

DEVICE_NAME=ev-charging-device
helm uninstall $DEVICE_NAME

############################
## Off street Parking Spot Devices
############################

DEVICE_NAME=parking-spot-device
helm uninstall $DEVICE_NAME

############################
## Pole Air Quality Observed Devices
############################

DEVICE_NAME=pole-air-quality-observed-device
helm uninstall $DEVICE_NAME

############################
## Pole Weather Observed Devices
############################

DEVICE_NAME=pole-weather-observed-device
helm uninstall $DEVICE_NAME

############################
## Pole Noise Level Observed Devices
############################

DEVICE_NAME=pole-noise-level-observed-device
helm uninstall $DEVICE_NAME

############################
## Pole Crowd Level Observed Devices
############################

DEVICE_NAME=pole-crowd-flow-observed-device
helm uninstall $DEVICE_NAME

############################
## Pole Traffic Level Observed Devices
############################

DEVICE_NAME=pole-traffic-flow-observed-device
helm uninstall $DEVICE_NAME

############################
## Streetlight Devices
############################

DEVICE_NAME=streetlight-device
helm uninstall $DEVICE_NAME