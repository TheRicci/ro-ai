package main

import (
	"context"
	"log"
	"os"
	"os/signal"
	"syscall"

	"ro-ai/agent/agent"
	"ro-ai/agent/kore"
	"ro-ai/agent/llm"
)

func main() {
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	planner := llm.Stub{Decision: agent.DecisionRest}
	executor := kore.Stub{}

	a := &agent.Agent{
		ID:      "agent-0",
		Name:    "Agent 0",
		Planner: planner,
		Kore:    executor,
	}

	go a.Run(ctx)

	<-ctx.Done()
	log.Printf("shutdown")
}
