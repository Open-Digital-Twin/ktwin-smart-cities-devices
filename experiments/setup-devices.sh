
# Values shared between all instances are in values.yaml
# Values specific for each instance is passed as parameter

APPLY_HELM=true

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

BATTERY_DEVICE_NAME=battery-device

# ############################
# ## EV Charging Devices
# ############################

EV_CHARGING_DEVICE_NAME=ev-charging-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for ev_charging_station in $(seq 1 $NUMBER_EV_CHARGING_STATION); do
        ev_charging_station_id=$(printf "ev%04d" $ev_charging_station)
        id=$(printf "%s-%s" $neighborhood_id $ev_charging_station_id)
        if [[ $APPLY_HELM == true ]]
        then
            helm upgrade --install $EV_CHARGING_DEVICE_NAME-$id smart-city \
                --set images[0].name=$EV_CHARGING_DEVICE_NAME-publisher \
                --set images[0].repository=ghcr.io/open-digital-twin/ktwin-$EV_CHARGING_DEVICE_NAME-publisher \
                --set images[0].pullPolicy=Always \
                --set images[0].tag="0.1" \
                --set images[0].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-evchargingstation/ngsi-ld-city-evchargingstation-$id \
                --set images[0].environmentVariables.clientId=$EV_CHARGING_DEVICE_NAME-publisher-$id \
                --set images[0].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="80;15;5;5;15;80" \
                --set images[0].environmentVariables.fullPeriod="10" \
                --set images[0].environmentVariables.partPeriod="4" &
        else
            echo "Applying EV Charging Device - ${id}"
        fi
    done
done

# Wait for processes to the closed
if [[ $APPLY_HELM == true ]]
then
    wait
fi

############################
## Off street Parking Spot Devices
############################

PARKING_SPOT_DEVICE_NAME=parking-spot-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for parking in $(seq 1 $NUMBER_OFFSTRET_PARKING); do
        parking_id=$(printf "ofp%04d" $parking)
        for parking_spot in $(seq 1 $NUMBER_OFFSTRET_PARKING_SPOT); do
            parking_spot_id=$(printf "s%04d" $parking_spot)
            id=$(printf "%s-%s-%s" $neighborhood_id $parking_id $parking_spot_id)
            if [[ $APPLY_HELM == true ]]
            then
                helm upgrade --install $PARKING_SPOT_DEVICE_NAME-$id smart-city \
                    --set images[0].name=$PARKING_SPOT_DEVICE_NAME-publisher-$id \
                    --set images[0].repository=ghcr.io/open-digital-twin/ktwin-$PARKING_SPOT_DEVICE_NAME-publisher \
                    --set images[0].pullPolicy=Always \
                    --set images[0].tag="0.1" \
                    --set images[0].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-parkingspot/ngsi-ld-city-offstreetparkingspot-$id \
                    --set images[0].environmentVariables.clientId=$PARKING_SPOT_DEVICE_NAME-publisher-$id \
                    --set images[0].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                    --set images[0].environmentVariables.messagePeriod="80;15;5;5;15;80" \
                    --set images[0].environmentVariables.fullPeriod="10" \
                    --set images[0].environmentVariables.partPeriod="4" \
                    --set images[1].name=$BATTERY_DEVICE_NAME-publisher \
                    --set images[1].repository=ghcr.io/open-digital-twin/ktwin-$BATTERY_DEVICE_NAME-publisher \
                    --set images[1].pullPolicy=Always \
                    --set images[1].tag="0.1" \
                    --set images[1].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-device/ngsi-ld-city-device-$id \
                    --set images[1].environmentVariables.clientId=$BATTERY_DEVICE_NAME-publisher-$id \
                    --set images[1].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                    --set images[0].environmentVariables.messagePeriod="240;120;240;240;120;240" \
                    --set images[1].environmentVariables.fullPeriod="10" \
                    --set images[1].environmentVariables.partPeriod="4" &
            else
                echo "Applying Off street Parking Spot Device - ${id}"
            fi
        done
    done
done

# Wait for processes to the closed
if [[ $APPLY_HELM == true ]]
then
    wait
fi

############################
## Pole Air Quality Observed Devices
############################

AIR_QUALITY_DEVICE_NAME=pole-air-quality-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for pole in $(seq 1 $NUMBER_POLE); do
        pole_id=$(printf "p%05d" $pole)
        id=$(printf "%s-%s" $neighborhood_id $pole_id)
        if [[ $APPLY_HELM == true ]]
        then
            helm upgrade --install $AIR_QUALITY_DEVICE_NAME-$id smart-city \
                --set images[0].name=$AIR_QUALITY_DEVICE_NAME-publisher-$id \
                --set images[0].repository=ghcr.io/open-digital-twin/ktwin-$AIR_QUALITY_DEVICE_NAME-publisher \
                --set images[0].pullPolicy=Always \
                --set images[0].tag="0.1" \
                --set images[0].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-airqualityobserved/ngsi-ld-city-airqualityobserved-$id \
                --set images[0].environmentVariables.clientId=$AIR_QUALITY_DEVICE_NAME-publisher-$id \
                --set images[0].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="10;10;10;10;10;10" \
                --set images[0].environmentVariables.fullPeriod="10" \
                --set images[0].environmentVariables.partPeriod="4" \
                --set images[1].name=$BATTERY_DEVICE_NAME-publisher \
                --set images[1].repository=ghcr.io/open-digital-twin/ktwin-$BATTERY_DEVICE_NAME-publisher \
                --set images[1].pullPolicy=Always \
                --set images[1].tag="0.1" \
                --set images[1].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-device/ngsi-ld-city-device-$id \
                --set images[1].environmentVariables.clientId=$BATTERY_DEVICE_NAME-publisher-$id \
                --set images[1].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="240;120;240;240;120;240" \
                --set images[1].environmentVariables.fullPeriod="10" \
                --set images[1].environmentVariables.partPeriod="4" &
        else
            echo "Applying Pole Air Quality Observed Device - ${id}"
        fi
    done
done

# Wait for processes to the closed
if [[ $APPLY_HELM == true ]]
then
    wait
fi

############################
## Pole Weather Observed Devices
############################

POLE_WEATHER_DEVICE_NAME=pole-weather-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for pole in $(seq 1 $NUMBER_POLE); do
        pole_id=$(printf "p%05d" $pole)
        id=$(printf "%s-%s" $neighborhood_id $pole_id)
        if [[ $APPLY_HELM == true ]]
        then
            helm upgrade --install $POLE_WEATHER_DEVICE_NAME-$id smart-city \
                --set images[0].name=$POLE_WEATHER_DEVICE_NAME-publisher-$id \
                --set images[0].repository=ghcr.io/open-digital-twin/ktwin-$POLE_WEATHER_DEVICE_NAME-publisher \
                --set images[0].pullPolicy=Always \
                --set images[0].tag="0.1" \
                --set images[0].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-weatherobserved/ngsi-ld-city-weatherobserved-$id \
                --set images[0].environmentVariables.clientId=$POLE_WEATHER_DEVICE_NAME-publisher-$id \
                --set images[0].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="10;10;10;10;10;10" \
                --set images[0].environmentVariables.fullPeriod="10" \
                --set images[0].environmentVariables.partPeriod="4" \
                --set images[1].name=$BATTERY_DEVICE_NAME-publisher \
                --set images[1].repository=ghcr.io/open-digital-twin/ktwin-$BATTERY_DEVICE_NAME-publisher \
                --set images[1].pullPolicy=Always \
                --set images[1].tag="0.1" \
                --set images[1].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-device/ngsi-ld-city-device-$id \
                --set images[1].environmentVariables.clientId=$BATTERY_DEVICE_NAME-publisher-$id \
                --set images[1].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="240;120;240;240;120;240" \
                --set images[1].environmentVariables.fullPeriod="10" \
                --set images[1].environmentVariables.partPeriod="4" &
        else
            echo "Applying Pole Weather Observed Devices - ${id}"
        fi
    done
done

# Wait for processes to the closed
if [[ $APPLY_HELM == true ]]
then
    wait
fi

############################
## Pole Noise Level Observed Devices
############################

POLE_NOISE_LEVEL_DEVICE_NAME=pole-noise-level-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for pole in $(seq 1 $NUMBER_POLE); do
        pole_id=$(printf "p%05d" $pole)
        id=$(printf "%s-%s" $neighborhood_id $pole_id)
        if [[ $APPLY_HELM == true ]]
        then
            helm upgrade --install $POLE_NOISE_LEVEL_DEVICE_NAME-$id smart-city \
                --set images[0].name=$POLE_NOISE_LEVEL_DEVICE_NAME-publisher-$id \
                --set images[0].repository=ghcr.io/open-digital-twin/ktwin-$POLE_NOISE_LEVEL_DEVICE_NAME-publisher \
                --set images[0].pullPolicy=Always \
                --set images[0].tag="0.1" \
                --set images[0].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-noiselevelobserved/ngsi-ld-city-noiselevelobserved-$id \
                --set images[0].environmentVariables.clientId=$POLE_NOISE_LEVEL_DEVICE_NAME-publisher-$id \
                --set images[0].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="10;10;10;10;10;10" \
                --set images[0].environmentVariables.fullPeriod="10" \
                --set images[0].environmentVariables.partPeriod="4" \
                --set images[1].name=$BATTERY_DEVICE_NAME-publisher \
                --set images[1].repository=ghcr.io/open-digital-twin/ktwin-$BATTERY_DEVICE_NAME-publisher \
                --set images[1].pullPolicy=Always \
                --set images[1].tag="0.1" \
                --set images[1].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-device/ngsi-ld-city-device-$id \
                --set images[1].environmentVariables.clientId=$BATTERY_DEVICE_NAME-publisher-$id \
                --set images[1].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="240;120;240;240;120;240" \
                --set images[1].environmentVariables.fullPeriod="10" \
                --set images[1].environmentVariables.partPeriod="4" &
        else
            echo "Applying Pole Noise Level Observed Devices - ${id}"
        fi
    done
done

# Wait for processes to the closed
if [[ $APPLY_HELM == true ]]
then
    wait
fi

############################
## Pole Crowd Level Observed Devices
############################

POLE_CROWD_LEVEL_DEVICE_NAME=pole-crowd-flow-observed-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for pole in $(seq 1 $NUMBER_POLE); do
        pole_id=$(printf "p%05d" $pole)
        id=$(printf "%s-%s" $neighborhood_id $pole_id)
        if [[ $APPLY_HELM == true ]]
        then
            helm upgrade --install $POLE_CROWD_LEVEL_DEVICE_NAME-$id smart-city \
                --set images[0].name=$POLE_CROWD_LEVEL_DEVICE_NAME-publisher-$id \
                --set images[0].repository=ghcr.io/open-digital-twin/ktwin-$POLE_CROWD_LEVEL_DEVICE_NAME-publisher \
                --set images[0].pullPolicy=Always \
                --set images[0].tag="0.1" \
                --set images[0].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-crowdflowobserved/ngsi-ld-city-crowdflowobserved-$id \
                --set images[0].environmentVariables.clientId=$POLE_CROWD_LEVEL_DEVICE_NAME-publisher-$id \
                --set images[0].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="10;10;10;10;10;10" \
                --set images[0].environmentVariables.fullPeriod="10" \
                --set images[0].environmentVariables.partPeriod="4" \
                --set images[1].name=$BATTERY_DEVICE_NAME-publisher \
                --set images[1].repository=ghcr.io/open-digital-twin/ktwin-$BATTERY_DEVICE_NAME-publisher \
                --set images[1].pullPolicy=Always \
                --set images[1].tag="0.1" \
                --set images[1].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-device/ngsi-ld-city-device-$id \
                --set images[1].environmentVariables.clientId=$BATTERY_DEVICE_NAME-publisher-$id \
                --set images[1].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="240;120;240;240;120;240" \
                --set images[1].environmentVariables.fullPeriod="10" \
                --set images[1].environmentVariables.partPeriod="4" &
        else
            echo "Applying Pole Crowd Level Observed Device - ${id}"
        fi
    done
done

# Wait for processes to the closed
if [[ $APPLY_HELM == true ]]
then
    wait
fi

############################
## Streetlight Devices
############################

STREETLIGHT_DEVICE_NAME=streetlight-device
for neighborhood in $(seq 1 $NUMBER_NEIGHBORHOOD); do
    neighborhood_id=$(printf "nb%03d" $neighborhood)
    for streetlight in $(seq 1 $NUMBER_STREETLIGHTS); do
        streetlight_id=$(printf "sl%05d" $streetlight)
        id=$(printf "%s-%s" $neighborhood_id $streetlight_id)
        if [[ $APPLY_HELM == true ]]
        then
            helm upgrade --install $STREETLIGHT_DEVICE_NAME-$id smart-city \
                --set images[0].name=$STREETLIGHT_DEVICE_NAME-publisher-$id \
                --set images[0].repository=ghcr.io/open-digital-twin/ktwin-$STREETLIGHT_DEVICE_NAME-publisher \
                --set images[0].pullPolicy=Always \
                --set images[0].tag="0.1" \
                --set images[0].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-streetlight/ngsi-ld-city-streetlight-$id \
                --set images[0].environmentVariables.clientId=$STREETLIGHT_DEVICE_NAME-publisher-$id \
                --set images[0].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="240;120;240;240;120;240" \
                --set images[0].environmentVariables.fullPeriod="10" \
                --set images[0].environmentVariables.partPeriod="4" \
                --set images[1].name=$BATTERY_DEVICE_NAME-publisher \
                --set images[1].repository=ghcr.io/open-digital-twin/ktwin-$BATTERY_DEVICE_NAME-publisher \
                --set images[1].pullPolicy=Always \
                --set images[1].tag="0.1" \
                --set images[1].environmentVariables.brokerTopic=ktwin/real/ngsi-ld-city-device/ngsi-ld-city-device-$id \
                --set images[1].environmentVariables.clientId=$BATTERY_DEVICE_NAME-publisher-$id \
                --set images[1].environmentVariables.fullTimeFrames="240;240;240;240;240;240" \
                --set images[0].environmentVariables.messagePeriod="240;120;240;240;120;240" \
                --set images[1].environmentVariables.fullPeriod="10" \
                --set images[1].environmentVariables.partPeriod="4" &
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