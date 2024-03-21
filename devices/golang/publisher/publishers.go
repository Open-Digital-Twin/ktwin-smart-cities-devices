package publisher

import (
	"fmt"
	"os"
	"sync"

	"github.com/Open-Digital-Twin/ktwin-smart-cities-devices/mqtt"
	"github.com/joho/godotenv"
)

func RunPublishers(callback func(messageCount, partPeriod, fullPeriod int) string) {
	if os.Getenv("ENV") == "local" {
		if err := godotenv.Load("publishers-local.env"); err != nil {
			fmt.Println("Error loading publishers-local.env file")
			return
		}
	}

	mqttClientConfig := mqtt.MQTTClientConfig{}
	mqttClientConfig.LoadMQTTConfig()

	publisherClientConfig := mqtt.PublisherClientConfig{}
	publisherClientConfig.LoadPublisherConfig()

	fmt.Println("Number of devices:", publisherClientConfig.NumberOfDevices)

	var wg sync.WaitGroup
	wg.Add(publisherClientConfig.NumberOfDevices)

	for i := 0; i < publisherClientConfig.NumberOfDevices; i++ {
		clientID := os.Getenv(fmt.Sprintf("CLIENT_ID_%d", i))
		brokerTopic := os.Getenv(fmt.Sprintf("BROKER_TOPIC_%d", i))

		if clientID == "" {
			panic(fmt.Sprintf("CLIENT_ID_%d is empty", i))
		}

		if brokerTopic == "" {
			panic(fmt.Sprintf("BROKER_TOPIC_%d is empty", i))
		}

		go runDevice(mqttClientConfig, publisherClientConfig, clientID, brokerTopic, &wg, callback)
	}

	wg.Wait()

	fmt.Println("All devices have finished")
}
