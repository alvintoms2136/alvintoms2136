#!/usr/bin/env sh
set -euo pipefail

OPENCLAW_HOME="${OPENCLAW_HOME:-${HOME:-/home/clawdbot}/.openclaw}"
CONFIG_FILE="${OPENCLAW_HOME}/config.json"

mkdir -p "${OPENCLAW_HOME}"

if [ ! -f "${CONFIG_FILE}" ]; then
  echo "[openclaw] No config found. Bootstrapping defaults."

  PROVIDER="anthropic"
  if [ -n "${OPENAI_API_KEY:-}" ]; then
    PROVIDER="openai"
  fi

  cat > "${CONFIG_FILE}" <<CONFIG
{
  "gateway": {
    "host": "0.0.0.0",
    "port": 18789,
    "mode": "${GATEWAY_MODE:-local}",
    "token": "${CLAWDBOT_GATEWAY_TOKEN:-}"
  },
  "providers": {
    "anthropic": {
      "apiKey": "${ANTHROPIC_API_KEY:-}"
    },
    "openai": {
      "apiKey": "${OPENAI_API_KEY:-}"
    }
  },
  "defaults": {
    "provider": "${PROVIDER}"
  }
}
CONFIG

  chmod 600 "${CONFIG_FILE}"
fi

echo "[openclaw] Starting gateway on 0.0.0.0:18789"
exec openclaw gateway --host 0.0.0.0
