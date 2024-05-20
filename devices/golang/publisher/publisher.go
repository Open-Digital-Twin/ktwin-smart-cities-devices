package publisher

import (
	"fmt"
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

		// No message to send in this window
		if messagePeriod <= 0 {
			// Wait for the window to end
			fmt.Printf("Nothing to publish in the window. Waiting for window to end. Window duration: %d\n", messageWindow)
			time.Sleep(time.Duration(messageWindow) * time.Second)
			continue
		}

		remainingMessageWindow := float64(messageWindow)

		for remainingMessageWindow > 0 {
			if remainingMessageWindow < messagePeriod {
				messagePeriod = remainingMessageWindow
			}

			// Wait
			time.Sleep(time.Duration(messagePeriod * float64(time.Second)))

			message := callback(messageCount, publisherClientConfig.PartPeriod, publisherClientConfig.FullPeriod)
			client.Publish(message)

			remainingMessageWindow = remainingMessageWindow - messagePeriod
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
