# ai_control OpenKore Plugin

Local TCP control channel for OpenKore, intended for the Go agent hub.

## Config
Add these to `control/config.txt` or a per-bot profile config:

```
aiControl 1
aiControl_host 127.0.0.1
aiControl_port 26050
aiControl_token change_me   # optional
```

## Loading
Add `ai_control` to `loadPlugins_list` in `control/sys.txt` (or profile `sys.txt`).

## Protocol
- Line-based. One command per line.
- Optional auth: if `aiControl_token` is set, first line must be `AUTH <token>`.
- Commands are OpenKore console commands, for example: `attack auto`, `move prontera`.
- Special commands: `PING` -> `PONG`, `QUIT` -> closes.
- Responses: `OK`, `ERR AUTH_REQUIRED`, `ERR AUTH`, `ERR COMMAND`.
