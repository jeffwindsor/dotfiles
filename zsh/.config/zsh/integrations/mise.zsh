#!/usr/bin/env zsh
# Mise - Runtime manager (hybrid: eager PATH, lazy hooks)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi
