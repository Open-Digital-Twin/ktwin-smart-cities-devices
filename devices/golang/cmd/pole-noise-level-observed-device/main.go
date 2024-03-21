package main

import (
	"encoding/json"
	"fmt"
	"time"

	publisher "github.com/Open-Digital-Twin/ktwin-smart-cities-devices/publisher"
)

func buildMessage(messageCount, partPeriod, fullPeriod int) string {
	msg := buildNoiseLevelObserved()
	msg["msg_count"] = messageCount
	msg["timestamp"] = time.Now().Format(time.RFC3339)

	msgBytes, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Error marshaling message:", err)
	}
	return string(msgBytes)
}

func buildNoiseLevelObserved() map[string]interface{} {
	sensorData := make(map[string]interface{})
	sensorData["LASSoundPressure"] = 10
	sensorData["LAeqSoundPressure"] = 8
	sensorData["LAeq_dSoundPressure"] = 8
	sensorData["LAmaxSoundPressure"] = 8
	return sensorData
}

func main() {
	publisher.RunPublishers(buildMessage)
}
