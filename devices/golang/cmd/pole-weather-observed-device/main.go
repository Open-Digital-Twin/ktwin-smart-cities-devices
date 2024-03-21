package main

import (
	"encoding/json"
	"fmt"
	"time"

	publisher "github.com/Open-Digital-Twin/ktwin-smart-cities-devices/publisher"
)

func buildMessage(messageCount, partPeriod, fullPeriod int) string {
	msg := buildWeatherObserved()
	msg["msg_count"] = messageCount
	msg["timestamp"] = time.Now().Format(time.RFC3339)

	msgBytes, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Error marshaling message:", err)
	}
	return string(msgBytes)
}

func buildWeatherObserved() map[string]interface{} {
	sensorData := make(map[string]interface{})
	sensorData["atmosphericPressure"] = 10
	sensorData["dewpoint"] = 8
	sensorData["temperature"] = 8
	sensorData["illuminance"] = 8
	sensorData["precipitation"] = 8
	sensorData["relativeHumidity"] = 8
	sensorData["snowHeight"] = 8
	sensorData["solarRadiation"] = 8
	sensorData["streamGauge"] = 8
	sensorData["uVIndexMax"] = 8
	sensorData["visibility"] = 8
	sensorData["WindDirection"] = 8
	sensorData["WindSpeed"] = 8
	return sensorData
}

func main() {
	publisher.RunPublishers(buildMessage)
}
