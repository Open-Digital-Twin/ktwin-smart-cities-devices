
# Values shared between all instances are in values.yaml
# Values specific for each instance is passed as parameter

APPLY_HELM=false

if [[ $APPLY_HELM == true ]]
then
  echo "Running in production mode. Helm is going to be applied."
else
  echo "Running in debug mode. Helm is not going to be applied."
fi

# Configure number of sensors to initiate
NUMBER_NEIGHBORHOOD=1
NUMBER_POLE=100
NUMBER_EV_CHARGING_STATION=10
NUMBER_OFFSTRET_PARKING=5
NUMBER_OFFSTRET_PARKING_SPOT=10
NUMBER_STREETLIGHTS=100

############################
## Battery Devices
############################

# Battery Devices are informed by the same device that generates the original data
# NUMBER_DEVICES=10
# DEVICE_NAME=battery-device
# for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
#     neighborhood_id=$(printf "nb%03d" $neighborhood)
    
#     # Air Quality Observed Device
#     for pole in $(seq 1 $NUMBER_POLE); do
#         pole_id=$(printf "p%05d" $pole)
#         id=$(printf "aqo-%s-%s" $neighborhood_id $pole_id)
#         if [[ $APPLY_HELM == true ]]
#         then
#             helm upgrade --install $DEVICE_NAME-$id smart-city \
#                 --set nameOverride=$DEVICE_NAME-publisher-$id \
#                 --set fullnameOverride=$DEVICE_NAME-publisher-$id \
#                 --set image.name=$DEVICE_NAME-publisher \
#                 --set image.repository=ghcr.io/open-digital-twin/ktwin-$DEVICE_NAME-publisher \
#                 --set image.pullPolicy=Always \
#                 --set image.tag="0.1" \
#                 --set environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-device/ngsi-ld-city-device-$id \
#                 --set environmentVariables.clientId=$DEVICE_NAME-publisher-$id \
#                 --set environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
#                 --set environmentVariables.messagePeriod="20;20;20;20;20;20" \
#                 --set environmentVariables.fullPeriod="10" \
#                 --set environmentVariables.partPeriod="4" &
#         else
#             echo "Applying Battery Devices - ${id}"
#         fi
#     done

# done


# ############################
# ## EV Charging Devices
# ############################

DEVICE_NAME=ev-charging-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for ev_charging_station in $(seq 1 $NUMBER_EV_CHARGING_STATION); do
        ev_charging_station_id=$(printf "ev%04d" $ev_charging_station)
        id=$(printf "%s-%s" $neighborhood_id $ev_charging_station_id)
        if [[ $APPLY_HELM == true ]]
        then
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
        else
            echo "Applying EV Charging Device - ${id}"
        fi
    done
done

############################
## Off street Parking Spot Devices
############################

DEVICE_NAME=parking-spot-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for parking in $(seq 1 $NUMBER_OFFSTRET_PARKING); do
        parking_id=$(printf "ofp%04d" $parking)
        for parking_spot in $(seq 1 $NUMBER_OFFSTRET_PARKING_SPOT); do
            parking_spot_id=$(printf "s%04d" $parking_spot)
            id=$(printf "%s-%s-%s" $neighborhood_id $parking_id $parking_spot_id)
            if [[ $APPLY_HELM == true ]]
            then
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
            else
                echo "Applying Off street Parking Spot Device - ${id}"
            fi
        done
    done
done

exit

############################
## Pole Air Quality Observed Devices
############################

DEVICE_NAME=pole-air-quality-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for pole in $(seq 1 $NUMBER_POLE); do
        pole_id=$(printf "p%05d" $pole)
        id=$(printf "%s-%s" $neighborhood_id $pole_id)
        if [[ $APPLY_HELM == true ]]
        then
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
        else
            echo "Applying Pole Air Quality Observed Device - ${id}"
        fi
    done
done
exit
############################
## Pole Weather Observed Devices
############################

DEVICE_NAME=pole-weather-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for pole in $(seq 1 $NUMBER_POLE); do
        pole_id=$(printf "p%05d" $pole)
        id=$(printf "%s-%s" $neighborhood_id $pole_id)
        if [[ $APPLY_HELM == true ]]
        then
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
        else
            echo "Applying Pole Weather Observed Devices - ${id}"
        fi
    done
done

exit

############################
## Pole Noise Level Observed Devices
############################

DEVICE_NAME=pole-noise-level-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for pole in $(seq 1 $NUMBER_POLE); do
        pole_id=$(printf "p%05d" $pole)
        id=$(printf "%s-%s" $neighborhood_id $pole_id)
        if [[ $APPLY_HELM == true ]]
        then
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
        else
            echo "Applying Pole Noise Level Observed Devices - ${id}"
        fi
    done
done

exit

############################
## Pole Crowd Level Observed Devices
############################

DEVICE_NAME=pole-crowd-flow-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for pole in $(seq 1 $NUMBER_POLE); do
        pole_id=$(printf "p%05d" $pole)
        id=$(printf "%s-%s" $neighborhood_id $pole_id)
        if [[ $APPLY_HELM == true ]]
        then
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
        else
            echo "Applying Pole Crowd Level Observed Device - ${id}"
        fi
    done
done

############################
## Streetlight Devices
############################

DEVICE_NAME=streetlight-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for streetlight in $(seq 1 $NUMBER_STREETLIGHTS); do
        streetlight_id=$(printf "sl%05d" $streetlight)
        id=$(printf "%s-%s" $neighborhood_id $streetlight_id)
        if [[ $APPLY_HELM == true ]]
        then
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
        else
            echo "Applying Streetlight Device - ${id}"
        fi
    done
done

# Wait for processes to the closed
if [[ $APPLY_HELM == true ]]
then
    wait
fi