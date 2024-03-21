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

	sensorData["averageCrowdSpeed"] = generateAverageCrowdSpeed(msgCount, partPeriod, fullPeriod)
	sensorData["averageHeadwayTime"] = generateAverageHeadwayTime(msgCount, partPeriod, fullPeriod)
	sensorData["peopleCount"] = generateAveragePeopleCount(msgCount, partPeriod, fullPeriod)

	return sensorData
}

func generateAverageCrowdSpeed(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 2
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 8
	}

	return 2
}

func generateAverageHeadwayTime(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 1
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 6
	}

	return 2
}

func generateAveragePeopleCount(msgCount, partPeriod, fullPeriod int) int {
	if fullPeriod < partPeriod {
		panic("full_period must be greater than part_period")
	}

	if (msgCount % fullPeriod) < partPeriod {
		return 50
	}
	if (msgCount % fullPeriod) > partPeriod {
		return 5
	}

	return 2
}

func main() {
	publisher.RunPublishers(buildMessage)
}
