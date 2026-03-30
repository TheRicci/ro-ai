# ro-ai

`ro-ai` is a local-first Ragnarok Online sandbox built around AI-driven bot populations.

The goal is to run a private RO server where most "players" are AI-controlled bots that can grind, trade, party, and keep the world feeling alive without requiring real players.

## Goal

Build a system that is:

- private
- cheap to run
- scalable from a handful of bots to dozens
- portable enough that the agent layer can later move from Go to C++ without redesigning the rest of the stack

## Current Default Stack

- `rAthena` for the RO server
- `OpenKore` for bot execution
- `Go` for the agent hub
- `Ollama` for local LLM reasoning

## Architecture

The project is intentionally split into four layers:

```text
+----------------------------+
| Local LLM                  |  reasoning only
| (Ollama / llama.cpp)       |
+-------------^--------------+
              | HTTP
+-------------+--------------+
| Agent Hub (Go)             |
| - owns personality         |
| - owns memory              |
| - schedules decisions      |
| - calls LLM occasionally   |
+-------------^--------------+
              | TCP / IPC
+-------------+--------------+
| OpenKore instances         |
| - one per bot              |
| - pathfinding              |
| - combat                   |
| - inventory                |
+-------------^--------------+
              | packets
+-------------+--------------+
| Private RO server          |
| (rAthena / Hercules)       |
+----------------------------+
```

## Design Rules

- The LLM is a planner, never the executor.
- The agent owns personality, memory, and decision timing.
- OpenKore handles mechanics like movement, combat, and inventory.
- Decisions are discrete actions, not free-form text.
- Bots should scale gradually: `1 -> 5 -> 20 -> 50`.

## Mental Model

- `LLM` = reasoning cortex
- `Agent` = nervous system
- `OpenKore` = muscles
- `Server` = physics

## Why This Split Exists

- Prevents running one LLM per bot
- Lets one local model serve many bots
- Keeps personality as data, not compute
- Makes behavior easier to debug
- Keeps the agent layer portable to C++

## Agent Model

The agent is the real intelligence in the system.

```go
type Agent struct {
    ID          string
    Name        string
    Personality Personality
    Memory      Memory
    State       GameState
    Kore        *KoreClient
}
```

Each agent owns:

- personality
- memory
- game state
- decision timing
- interpretation of LLM output
- command dispatch to OpenKore

Example personality model:

```go
type Personality struct {
    Aggression float32
    Greed      float32
    Social     float32
    Risk       float32
}
```

Example memory model:

```go
type Memory struct {
    LastParty string
    LastDeath string
    Enemies   []string
}
```

## Decision Loop

Bots should not call the LLM every frame. Decisions happen on a timer or in response to important events.

```go
func (a *Agent) Run(ctx context.Context) {
    ticker := time.NewTicker(5 * time.Minute)

    for {
        select {
        case <-ticker.C:
            decision := a.Decide()
            a.Execute(decision)
        case <-ctx.Done():
            return
        }
    }
}
```

## LLM Contract

The model is used only for short, high-level decisions.

Allowed action vocabulary:

```text
GRIND
SELL
MOVE
REST
CHAT
```

Example prompt:

```text
You are controlling a Ragnarok Online character.

Personality:
- aggression: 0.8
- greed: 0.2
- social: 0.1

Current state:
- level 32 Knight
- map: Prontera
- zeny: low
- HP: full

Choose ONE action:
GRIND | SELL | MOVE | REST | CHAT
```

## OpenKore Role

The Go agent sends only high-level commands. OpenKore remains the headless player that executes game mechanics.

```go
type KoreClient struct {
    Conn net.Conn
}

func (k *KoreClient) Grind() {
    k.Send("attack auto")
}

func (k *KoreClient) Move(mapName string) {
    k.Send("move " + mapName)
}
```

OpenKore is responsible for:

- navigation
- combat
- item pickup
- NPC interaction

## Bot Configuration

Bots are intended to be data-driven:

```yaml
bots:
  - id: alice
    name: Alice
    personality:
      aggression: 0.8
      greed: 0.2
      social: 0.1
      risk: 0.6

  - id: bob
    name: Bob
    personality:
      aggression: 0.2
      greed: 0.9
      social: 0.5
      risk: 0.3
```

## Repository Layout

```text
ro-ai/
|-- agent/          Go agent hub
|-- docs/           setup and integration notes
|-- integrations/   integration-specific glue
|-- openkore/       vendored OpenKore tree
|-- rathena/        vendored rAthena tree
|-- summary.md      original project summary/spec
|-- TODO.md         project milestones
```

## Repo Status

This repo is currently centered on:

- server setup with `rAthena`
- bot execution through `OpenKore`
- Go scaffolding for the agent hub
- local integration work for the future AI control layer

## Useful Docs

- `docs/setup.md`
- `docs/integration.md`
- `docs/deps.md`
- `summary.md`
- `TODO.md`

## End Goal

A living RO server where:

- bots grind
- bots trade
- bots party
- towns feel populated
- markets move on their own
- everything runs on one machine

This project should be built to generate code against the architecture above, not to redesign it.
