package mqtt

import (
	"encoding/json"
	"fmt"
	"log"
	"os"

	pahoMqtt "github.com/eclipse/paho.mqtt.golang"
)

type MQTTClient struct {
	logger     *log.Logger
	mqttConfig MQTTClientConfig
	mqttClient pahoMqtt.Client
	clientId   string
	topic      string
}

func NewMQTTClient(config MQTTClientConfig, clientId, topic string) *MQTTClient {
	return &MQTTClient{
		logger:     log.New(os.Stdout, fmt.Sprintf("MQTTClient - %s - ", clientId), log.LstdFlags),
		mqttConfig: config,
		clientId:   clientId,
		topic:      topic,
	}
}

func (c *MQTTClient) ConnectMQTT() {
	onConnect := func(client pahoMqtt.Client) {
		c.logger.Printf("Connected to MQTT Broker on topic %s\n", c.topic)
	}

	opts := pahoMqtt.NewClientOptions().
		SetClientID(c.clientId).
		AddBroker(fmt.Sprintf("tcp://%s:%d", c.mqttConfig.BrokerAddress, c.mqttConfig.Port)).
		SetAutoReconnect(true).
		SetOnConnectHandler(onConnect)

	if c.mqttConfig.HasCredentials {
		opts.SetUsername(c.mqttConfig.Credentials.Username).SetPassword(c.mqttConfig.Credentials.Password)
	}

	c.mqttClient = pahoMqtt.NewClient(opts)
	if token := c.mqttClient.Connect(); token.Wait() && token.Error() != nil {
		c.logger.Printf("Error: %s\n" + token.Error().Error())
		c.logger.Fatalf("Failed to connect to topic %s, %v\n", c.topic, token.Error())
	}
}

func (c *MQTTClient) DisconnectMQTT() {
	c.logger.Printf("Disconnected")
	c.mqttClient.Disconnect(250)
}

func (c *MQTTClient) Publish(message string) {
	c.logger.Printf("Published to topic %s\n", c.topic)
	token := c.mqttClient.Publish(c.topic, 0, false, message)
	token.Wait()
	if token.Error() != nil {
		c.logger.Printf("Failed to send in client %s message to topic %s\n", c.mqttConfig.ClientID, c.topic)
		c.logger.Printf("Failed to send `%s` to topic `%s`\n", message, c.topic)
		c.logger.Println(token.Error())
	}
}

func (c *MQTTClient) Subscribe(callback func(map[string]interface{})) {
	onMessage := func(client pahoMqtt.Client, msg pahoMqtt.Message) {
		var msgDict map[string]interface{}
		if err := json.Unmarshal(msg.Payload(), &msgDict); err != nil {
			c.logger.Println("Error unmarshalling message:", err)
			return
		}
		callback(msgDict)
	}

	if token := c.mqttClient.Subscribe(c.topic, 0, onMessage); token.Wait() && token.Error() != nil {
		c.logger.Printf("Failed to subscribe to topic %s: %v\n", c.topic, token.Error())
		return
	}

	c.logger.Printf("Subscribed to topic %s\n", c.topic)

	defer c.mqttClient.Unsubscribe(c.topic)
}
