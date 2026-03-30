# Local Setup (Draft)

## Goal
Download the external components (rAthena, OpenKore, Ollama) and outline the wiring sequence.

## Prerequisites
- Git
- Go 1.24+
- PowerShell
- Ollama (local LLM runtime)

## Download External Components
Run the bootstrap script from the repo root:

```powershell
.\scripts\bootstrap.ps1
```

This will create or reuse:
- `rathena/` (server)
- `openkore/` (bot client)

If Ollama is not installed, the script will prompt you to install it.

## Install OpenKore Control Plugin
Run the plugin install script from the repo root:

```powershell
.\scripts\install_openkore_plugin.ps1
```

Then add `ai_control` to `loadPlugins_list` in `openkore/control/sys.txt` or your profile `sys.txt`.

## Wiring Sequence (High Level)
1. Start rAthena server.
2. Start one or more OpenKore instances (one per bot).
3. Start the Go agent hub, which connects to OpenKore control channels.
4. The agent hub calls Ollama over HTTP for discrete decisions.

## Notes
- Dependency pins are tracked in `docs/deps.md`.
- OpenKore control channel details are defined in `docs/integration.md`.
- This document will be expanded into the full runbook.
