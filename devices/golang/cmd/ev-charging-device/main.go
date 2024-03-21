package main

import (
	"encoding/json"
	"fmt"
	"time"

	publisher "github.com/Open-Digital-Twin/ktwin-smart-cities-devices/publisher"
)

func buildMessage(messageCount, partPeriod, fullPeriod int) string {
	msg := buildEVChargingMessage(messageCount, partPeriod, fullPeriod)
	msg["msg_count"] = messageCount
	msg["timestamp"] = time.Now().Format(time.RFC3339)

	msgBytes, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Error marshaling message:", err)
	}
	return string(msgBytes)
}

func buildEVChargingMessage(msgCount, partPeriod, fullPeriod int) map[string]interface{} {
	sensorData := make(map[string]interface{})

	sensorData["availableCapacity"] = getAvailableCapacity(msgCount, partPeriod, fullPeriod)

	return sensorData
}

func getAvailableCapacity(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 1
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 3
	}

	return 1
}

func main() {
	publisher.RunPublishers(buildMessage)
}
