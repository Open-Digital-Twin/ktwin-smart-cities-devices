package main

import (
	"encoding/json"
	"fmt"
	"time"

	publisher "github.com/Open-Digital-Twin/ktwin-smart-cities-devices/publisher"
)

func buildMessage(messageCount, partPeriod, fullPeriod int) string {
	msg := buildParkingSpotMessage(messageCount, partPeriod, fullPeriod)
	msg["msg_count"] = messageCount
	msg["timestamp"] = time.Now().Format(time.RFC3339)

	msgBytes, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Error marshaling message:", err)
	}
	return string(msgBytes)
}

func buildParkingSpotMessage(msgCount, partPeriod, fullPeriod int) map[string]interface{} {
	sensorData := make(map[string]interface{})

	status := generateStatus(msgCount, partPeriod, fullPeriod)
	sensorData["status"] = status

	return sensorData
}

func generateStatus(msgCount, partPeriod, fullPeriod int) string {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return "free"
	}
	if (msgCount % fullPeriod) > partPeriod {
		return "occupied"
	}

	return "free"
}

func main() {
	publisher.RunPublishers(buildMessage)
}
