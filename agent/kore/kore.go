package kore

import (
	"context"

	"ro-ai/agent/agent"
)

type Client interface {
	Execute(ctx context.Context, decision agent.Decision) error
}

type Stub struct{}

func (s Stub) Execute(ctx context.Context, decision agent.Decision) error {
	return nil
}
