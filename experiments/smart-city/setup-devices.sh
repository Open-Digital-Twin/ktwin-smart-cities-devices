
# Values shared between all instances are in values.yaml
# Values specific for each instance is passed as parameter

############################
## Battery Devices
############################

NUMBER_DEVICES=2
DEVICE_NAME=battery-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "%03d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-device/ngsi-ld-city-device-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.numberMessages="10" \
        --set environmentVariables.messagePeriod="0.5" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4"
done

############################
## EV Charging Devices
############################

NUMBER_DEVICES=2
DEVICE_NAME=ev-charging-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "%03d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-evchargingstation/ngsi-ld-city-evchargingstation-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.numberMessages="10" \
        --set environmentVariables.messagePeriod="0.5" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4"
done

############################
## Parking Spot Devices
############################

NUMBER_DEVICES=2
DEVICE_NAME=parking-spot-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "%03d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-parkingspot/ngsi-ld-city-offstreet-parkingspot-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.numberMessages="10" \
        --set environmentVariables.messagePeriod="0.5" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4"
done

############################
## Pole Air Quality Observed Devices
############################

NUMBER_DEVICES=2
DEVICE_NAME=pole-air-quality-observed-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "%03d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-airqualityobserved/ngsi-ld-city-airqualityobserved-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.numberMessages="10" \
        --set environmentVariables.messagePeriod="0.5" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4"
done

############################
## Pole Weather Observed Devices
############################

NUMBER_DEVICES=2
DEVICE_NAME=pole-weather-observed-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "%03d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-weatherobserved/ngsi-ld-city-weatherobserved-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.numberMessages="10" \
        --set environmentVariables.messagePeriod="0.5" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4"
done

############################
## Streetlight Devices
############################

NUMBER_DEVICES=2
DEVICE_NAME=streetlight-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "%03d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-streetlight/ngsi-ld-city-streetlight-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.numberMessages="10" \
        --set environmentVariables.messagePeriod="0.5" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4"
done
