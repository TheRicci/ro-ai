package agent

import (
	"context"
	"time"
)

type Planner interface {
	Decide(ctx context.Context, input DecisionInput) (Decision, error)
}

type KoreClient interface {
	Execute(ctx context.Context, decision Decision) error
}

type Agent struct {
	ID          string
	Name        string
	Personality Personality
	Memory      Memory
	State       GameState
	Kore        KoreClient
	Planner     Planner
	Interval    time.Duration
}

func (a *Agent) Run(ctx context.Context) {
	interval := a.Interval
	if interval <= 0 {
		interval = 5 * time.Minute
	}

	ticker := time.NewTicker(interval)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			_ = a.Step(ctx)
		case <-ctx.Done():
			return
		}
	}
}

func (a *Agent) Step(ctx context.Context) error {
	decision := a.Decide(ctx)
	if a.Kore == nil {
		return nil
	}
	return a.Kore.Execute(ctx, decision)
}

func (a *Agent) Decide(ctx context.Context) Decision {
	if a.Planner == nil {
		return DecisionRest
	}

	decision, err := a.Planner.Decide(ctx, DecisionInput{
		Personality: a.Personality,
		Memory:      a.Memory,
		State:       a.State,
	})
	if err != nil || !decision.Valid() {
		return DecisionRest
	}

	return decision
}
