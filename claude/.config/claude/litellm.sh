#!/usr/bin/env bash

# CJ LiteLLM backed Claude session
#   use the macos key chain to get your liteLLM api token under `anthropic-api-key`
#   you may put the key in the ENV variable ANTHROPIC_API_KEY

if [[ -z "$ANTHROPIC_API_KEY" ]]; then
  # Keychain lookup
  ANTHROPIC_API_KEY=$(security find-generic-password -a "$USER" -s "anthropic-api-key" -w 2>/dev/null)

  if [[ -z "$ANTHROPIC_API_KEY" ]]; then
    echo "LiteLLM API Key not found environment variable nor in macOS Keychain"
    echo "  Store it permanently in Keychain with: "
    echo "  security add-generic-password -a \"\$USER\" -s \"anthropic-api-key\" -w \"your-api-key\""
    echo ""
    read -rp "Please enter a personal access token: " ANTHROPIC_API_KEY
  else
    echo "personal access token obtained from macOS Keychain"
  fi

fi
ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" claude "$@"
