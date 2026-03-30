package config

import (
	"errors"

	"ro-ai/agent/agent"
)

type BotConfig struct {
	ID          string            `json:"id"`
	Name        string            `json:"name"`
	Personality agent.Personality `json:"personality"`
}

type Config struct {
	Bots []BotConfig `json:"bots"`
}

func Load(path string) (Config, error) {
	return Config{}, errors.New("config loader not implemented")
}
