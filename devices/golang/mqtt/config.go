package mqtt

import (
	"os"
	"strconv"
	"strings"
)

type MQTTClientConfig struct {
	HasCredentials bool
	ClientID       string
	BrokerAddress  string
	Port           int
	Credentials    MQTTClientCredentials
}

func (c *MQTTClientConfig) LoadMQTTConfig() {
	c.ClientID = os.Getenv("CLIENT_ID")
	c.BrokerAddress = os.Getenv("BROKER_ADDRESS")
	c.Port, _ = strconv.Atoi(os.Getenv("BROKER_PORT"))
	c.Credentials = MQTTClientCredentials{
		Username: os.Getenv("USERNAME"),
		Password: os.Getenv("PASSWORD"),
	}

	if c.Credentials.Username != "" && c.Credentials.Password != "" {
		c.HasCredentials = true
	}
}

type MQTTClientCredentials struct {
	Username string
	Password string
}

type PublisherClientConfig struct {
	// Total number of devices to be created as threads
	NumberOfDevices int
	// Number of messages to be sent in each window
	MessageWindows []int
	// Period of messages to be sent in each window
	MessagePeriods []float64
	// Full Period
	FullPeriod int
	// Part Period
	PartPeriod int
}

func (c *PublisherClientConfig) LoadPublisherConfig() {
	c.NumberOfDevices = loadEnvInt("NUMBER_DEVICES")
	c.FullPeriod = loadEnvInt("FULL_PERIOD")
	c.PartPeriod = loadEnvInt("PART_PERIOD")

	messageWindowsStr := os.Getenv("MESSAGE_WINDOWS")
	messagePeriodsStr := os.Getenv("MESSAGE_PERIODS")

	messageWindowsInt := strings.Split(messageWindowsStr, ";")
	messagePeriodsInt := strings.Split(messagePeriodsStr, ";")

	if len(messageWindowsInt) != len(messagePeriodsInt) {
		panic("Message windows and periods must be the same length")
	}

	for _, mw := range messageWindowsInt {
		intVal, err := strconv.Atoi(mw)
		if err != nil {
			panic(err)
		}
		c.MessageWindows = append(c.MessageWindows, intVal)
	}

	for _, mw := range messagePeriodsInt {
		floatVal, err := strconv.ParseFloat(mw, 32)
		if err != nil {
			panic(err)
		}
		c.MessagePeriods = append(c.MessagePeriods, floatVal)
	}
}

func loadEnvInt(envKey string) int {
	intVar, err := strconv.Atoi(os.Getenv(envKey))
	if err != nil {
		panic(envKey + " - " + err.Error())
	}
	return intVar
}
