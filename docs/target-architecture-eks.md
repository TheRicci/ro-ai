# Target Architecture Note (EKS)

## Purpose

This note records the long-term production target for the project.

It is intentionally different from the current local development wiring in the repository.
The current repo remains the local prototype and integration sandbox.
This document is the "north star" for the future EKS-based platform.

## Core Decisions

- `1 bot = 1 OpenKore runtime`
- `rAthena world data` and `bot AI data` are stored separately
- local `127.0.0.1` integration is a development convenience, not the final network model
- the platform should be decoupled by service boundaries, not by shared process memory

## Long-Term Target

The long-term EKS target is split into four planes:

1. `World plane`
Runs `rAthena` login, char, and map services.
Owns the authoritative Ragnarok world state.
Persists to a dedicated MariaDB-compatible world database.

2. `Execution plane`
Runs one bot pod per bot runtime.
Each bot pod owns exactly one OpenKore process.
OpenKore should be wrapped by a thin bot adapter so the rest of the platform does not couple directly to OpenKore internals.

3. `Intelligence plane`
Runs shared planner services, model gateway services, and related orchestration logic.
This layer decides what bots should do, but does not own the game-mechanics execution process.

4. `Bot data plane`
Stores bot personalities, long-term memory, relationships, and other non-world AI data in a separate store from rAthena's world database.
Large artifacts such as transcripts, journals, or snapshots can be stored separately from hot structured metadata.

## Why This Matters

- The current repo is optimized for learning and local iteration.
- The future EKS architecture is optimized for decoupling, fault isolation, and scaling.
- Keeping those two ideas separate helps us avoid locking the project into local-only assumptions.

## Repository Note

The top-level `ro-ai-eks/` folder is a seed for the future standalone EKS/infrastructure repository.
It does not define the current runtime architecture by itself.
It exists so the production target can evolve independently from the local prototype.
