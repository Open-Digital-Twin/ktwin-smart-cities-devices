package main

import (
	"encoding/json"
	"fmt"
	"time"

	publisher "github.com/Open-Digital-Twin/ktwin-smart-cities-devices/publisher"
)

func buildMessage(messageCount, partPeriod, fullPeriod int) string {
	msg := buildStreetlightMessage(messageCount, partPeriod, fullPeriod)
	msg["msg_count"] = messageCount
	msg["timestamp"] = time.Now().Format(time.RFC3339)

	msgBytes, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Error marshaling message:", err)
	}
	return string(msgBytes)
}

func buildStreetlightMessage(msgCount int, partPeriod, fullPeriod int) map[string]interface{} {
	sensorData := make(map[string]interface{})

	sensorData["powerState"] = generatePowerState(msgCount, partPeriod, fullPeriod)
	return sensorData
}

func generatePowerState(msgCount, partPeriod, fullPeriod int) string {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return "off"
	}
	if (msgCount % fullPeriod) > partPeriod {
		return "on"
	}

	return "off"
}

func main() {
	publisher.RunPublishers(buildMessage)
}
