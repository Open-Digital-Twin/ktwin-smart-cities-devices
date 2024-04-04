package publisher

import (
	"fmt"
	"math"
	"runtime"
	"sync"
	"time"

	"github.com/Open-Digital-Twin/ktwin-smart-cities-devices/mqtt"
)

func runDevice(mqttClientConfig mqtt.MQTTClientConfig, publisherClientConfig mqtt.PublisherClientConfig, clientId, topicId string, wg *sync.WaitGroup, callback func(messageCount, partPeriod, fullPeriod int) string) {
	fmt.Printf("Starting device %s\n", clientId)

	client := mqtt.NewMQTTClient(mqttClientConfig, clientId, topicId)
	client.ConnectMQTT()

	messageCount := 0

	for windowIndex, messageWindow := range publisherClientConfig.MessageWindows {
		messagePeriod := publisherClientConfig.MessagePeriods[windowIndex]
		numberOfMessages := int(math.Ceil(float64(messageWindow) / messagePeriod))

		for i := 0; i < numberOfMessages; i++ {
			message := callback(messageCount, publisherClientConfig.PartPeriod, publisherClientConfig.FullPeriod)
			client.Publish(message)

			// Wait
			time.Sleep(time.Duration(messagePeriod * float64(time.Second)))
		}
		messageCount++
	}

	client.DisconnectMQTT()

	wg.Done()
}

func PrintMemUsage() {
	var m runtime.MemStats
	runtime.ReadMemStats(&m)
	fmt.Printf("Alloc = %v MiB", m.Alloc/1024/1024)
	fmt.Printf("\tTotalAlloc = %v MiB", m.TotalAlloc/1024/1024)
	fmt.Printf("\tSys = %v MiB", m.Sys/1024/1024)
	fmt.Printf("\tNumGC = %v\n", m.NumGC)
}
