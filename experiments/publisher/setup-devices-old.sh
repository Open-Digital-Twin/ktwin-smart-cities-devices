
# Values shared between all instances are in values.yaml
# Values specific for each instance is passed as parameter

############################
## Battery Devices
############################

NUMBER_DEVICES=10
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
        --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
        --set environmentVariables.messagePeriod="20;20;20;20;20;20" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4" &
done

# ############################
# ## EV Charging Devices
# ############################

NUMBER_DEVICES=10
DEVICE_NAME=ev-charging-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "nb001-ev%04d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-evchargingstation/ngsi-ld-city-evchargingstation-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
        --set environmentVariables.messagePeriod="80;15;5;5;15;80" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4" &
done

############################
## Off street Parking Spot Devices
############################

NUMBER_NEIGHBORHOOD=1
NUMBER_PARKING=5
NUMBER_PARKING_SPOT=10
DEVICE_NAME=parking-spot-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for parking in $(seq 1 $NUMBER_PARKING); do
        parking_id=$(printf "ofp%04d" $parking)
        for parking_spot in $(seq 1 $NUMBER_PARKING_SPOT); do
            parking_spot_id=$(printf "s%04d" $parking_spot)
            id=$(printf "%s-%s-%s" $neighborhood_id $parking_id $parking_spot_id)
            helm upgrade --install $DEVICE_NAME-$id smart-city \
                --set nameOverride=$DEVICE_NAME-publisher-$id \
                --set fullnameOverride=$DEVICE_NAME-publisher-$id \
                --set image.name=$DEVICE_NAME-publisher \
                --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
                --set image.pullPolicy=Always \
                --set image.tag="0.1" \
                --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-parkingspot/ngsi-ld-city-offstreetparkingspot-$id \
                --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
                --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set environmentVariables.messagePeriod="80;15;5;5;15;80" \
                --set environmentVariables.fullPeriod="10" \
                --set environmentVariables.partPeriod="4" &
        done
    done
done

exit

############################
## Pole Air Quality Observed Devices
############################

NUMBER_DEVICES=10
DEVICE_NAME=pole-air-quality-observed-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "nb001-p%05d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-airqualityobserved/ngsi-ld-city-airqualityobserved-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
        --set environmentVariables.messagePeriod="10;10;10;10;10;10" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4" &
done

############################
## Pole Weather Observed Devices
############################

NUMBER_DEVICES=10
DEVICE_NAME=pole-weather-observed-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "nb001-p%05d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-weatherobserved/ngsi-ld-city-weatherobserved-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
        --set environmentVariables.messagePeriod="10;10;10;10;10;10" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4" &
done

############################
## Pole Noise Level Observed Devices
############################

NUMBER_DEVICES=10
DEVICE_NAME=pole-noise-level-observed-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "nb001-p%05d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-noiselevelobserved/ngsi-ld-city-noiselevelobserved-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
        --set environmentVariables.messagePeriod="10;10;10;10;10;10" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4" &
done

############################
## Pole Crowd Level Observed Devices
############################

NUMBER_DEVICES=10
DEVICE_NAME=pole-crowd-flow-observed-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "nb001-p%05d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-crowdflowobserved/ngsi-ld-city-crowdflowobserved-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
        --set environmentVariables.messagePeriod="10;10;10;10;10;10" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4" &
done

############################
## Streetlight Devices
############################

NUMBER_DEVICES=10
DEVICE_NAME=streetlight-device
for counter in $(seq 1 $NUMBER_DEVICES); do
    # Format ID
    id=$(printf "nb001-sl%05d" $counter)
    helm upgrade --install $DEVICE_NAME-$id smart-city \
        --set nameOverride=$DEVICE_NAME-publisher-$id \
        --set fullnameOverride=$DEVICE_NAME-publisher-$id \
        --set image.name=$DEVICE_NAME-publisher \
        --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
        --set image.pullPolicy=Always \
        --set image.tag="0.1" \
        --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-streetlight/ngsi-ld-city-streetlight-$id \
        --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
        --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
        --set environmentVariables.messagePeriod="240;120;240;240;120;240" \
        --set environmentVariables.fullPeriod="10" \
        --set environmentVariables.partPeriod="4" &
done

# Wait for processes to the closed
wait