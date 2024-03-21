package main

import (
	"encoding/json"
	"fmt"
	"time"

	publisher "github.com/Open-Digital-Twin/ktwin-smart-cities-devices/publisher"
)

func buildMessage(messageCount, partPeriod, fullPeriod int) string {
	msg := buildBatteryMessage(messageCount, partPeriod, fullPeriod)
	msg["msg_count"] = messageCount
	msg["timestamp"] = time.Now().Format(time.RFC3339)

	msgBytes, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Error marshaling message:", err)
	}

	return string(msgBytes)
}

func buildBatteryMessage(msgCount, partPeriod, fullPeriod int) map[string]interface{} {
	sensorData := make(map[string]interface{})

	sensorData["batteryLevel"] = getBatteryLevel(msgCount, partPeriod, fullPeriod)
	sensorData["measurementFrequency"] = getMeasureFrequencyLevel(msgCount, partPeriod+partPeriod/3, fullPeriod+partPeriod/3)

	return sensorData
}

func getBatteryLevel(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 90
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 12
	}

	return 90
}

func getMeasureFrequencyLevel(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 15
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 60
	}

	return 90
}

func main() {
	publisher.RunPublishers(buildMessage)
}
