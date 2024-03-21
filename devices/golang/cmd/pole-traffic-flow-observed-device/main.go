package main

import (
	"encoding/json"
	"fmt"
	"time"

	publisher "github.com/Open-Digital-Twin/ktwin-smart-cities-devices/publisher"
)

func buildMessage(messageCount, partPeriod, fullPeriod int) string {
	msg := buildCrowdFlowObserved(messageCount, partPeriod, fullPeriod)
	msg["msg_count"] = messageCount
	msg["dateObservedTo"] = time.Now().Format(time.RFC3339)
	msg["dateObservedFrom"] = time.Now().Format(time.RFC3339)

	msgBytes, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Error marshaling message:", err)
	}
	return string(msgBytes)
}

func buildCrowdFlowObserved(msgCount int, partPeriod, fullPeriod int) map[string]interface{} {
	sensorData := make(map[string]interface{})

	sensorData["averageVehicleSpeed"] = generateAverageVehicleSpeed(msgCount, partPeriod, fullPeriod)
	sensorData["averageHeadwayTime"] = generateAverageHeadwayTime(msgCount, partPeriod, fullPeriod)
	sensorData["averageGapDistance"] = generateAverageGapDistance(msgCount, partPeriod, fullPeriod)
	sensorData["averageVehicleLength"] = generateAverageVehicleLength(msgCount, partPeriod, fullPeriod)

	return sensorData
}

func generateAverageVehicleSpeed(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 10
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 50
	}

	return 10
}

func generateAverageHeadwayTime(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 1
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 5
	}

	return 5
}

func generateAverageGapDistance(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 3
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 50
	}

	return 3
}

func generateAverageVehicleLength(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 200
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 5
	}

	return 200
}

func main() {
	publisher.RunPublishers(buildMessage)
}
