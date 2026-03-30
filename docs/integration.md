# Integration Overview

## Components
- rAthena server (login, char, map)
- OpenKore bots (1 per bot)
- Go agent hub
- Ollama (local LLM)

## Control Channel (Agent -> OpenKore)
- OpenKore loads the `ai_control` plugin.
- Each bot exposes a local TCP port (`aiControl_port`) on `127.0.0.1`.
- The agent sends line-based commands over TCP.
- Responses are `OK` or `ERR ...`.

### Protocol Summary
- Optional auth: if `aiControl_token` is set, the first line must be `AUTH <token>`.
- `PING` -> `PONG`
- `QUIT` -> close connection
- Any other line is executed as an OpenKore console command.

## Agent Command Mapping (planned)
- `GRIND` -> `attack auto`
- `SELL` -> `autosell`
- `MOVE <map>` -> `move <map>`
- `REST` -> `sit`
- `CHAT <msg>` -> `c <msg>`

## Ports and Endpoints
- rAthena defaults: login `6900` (`rathena/conf/login_athena.conf`), char `6121` (`rathena/conf/char_athena.conf`), map `5121` (`rathena/conf/map_athena.conf`)
- Ollama default: `http://localhost:11434`
- ai_control: one port per bot, for example `26050`, `26051`, `26052`

## Startup Order
1. Start rAthena (login, char, map).
2. Start Ollama.
3. Start OpenKore bots with `ai_control` enabled.
4. Start the Go agent hub.
