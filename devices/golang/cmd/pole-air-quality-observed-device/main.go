package main

import (
	"encoding/json"
	"fmt"
	"time"

	publisher "github.com/Open-Digital-Twin/ktwin-smart-cities-devices/publisher"
)

func buildMessage(messageCount, partPeriod, fullPeriod int) string {
	msg := buildAirQualityObserved()
	msg["msg_count"] = messageCount
	msg["timestamp"] = time.Now().Format(time.RFC3339)

	msgBytes, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Error marshaling message:", err)
	}
	return string(msgBytes)
}

func buildAirQualityObserved() map[string]interface{} {
	sensorData := make(map[string]interface{})
	sensorData["reliability"] = 8
	sensorData["volatileOrganicCompoundsTotal"] = 0
	sensorData["CO2Density"] = 8
	sensorData["CODensity"] = 8
	sensorData["PM1Density"] = 8
	sensorData["PM10Density"] = 8
	sensorData["PM25Density"] = 8
	sensorData["SO2Density"] = 8
	sensorData["C6H6Density"] = 8
	sensorData["NIDensity"] = 8
	sensorData["NODensity"] = 8
	sensorData["ASDensity"] = 8
	sensorData["CDDensity"] = 8
	sensorData["NO2Density"] = 8
	sensorData["O3Density"] = 8
	sensorData["PBDensity"] = 8
	sensorData["SH2Density"] = 8
	sensorData["precipitation"] = 8
	sensorData["temperature"] = 8
	sensorData["WindDirection"] = 8
	sensorData["WindSpeed"] = 8
	sensorData["relativeHumidity"] = 8
	return sensorData
}

func main() {
	publisher.RunPublishers(buildMessage)
}
