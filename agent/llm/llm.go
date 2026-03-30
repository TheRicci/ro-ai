package llm

import (
	"context"

	"ro-ai/agent/agent"
)

type Client interface {
	Decide(ctx context.Context, input agent.DecisionInput) (agent.Decision, error)
}

type Stub struct {
	Decision agent.Decision
}

func (s Stub) Decide(ctx context.Context, input agent.DecisionInput) (agent.Decision, error) {
	if s.Decision == "" {
		return agent.DecisionRest, nil
	}
	return s.Decision, nil
}
