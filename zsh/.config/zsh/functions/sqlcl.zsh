#!/usr/bin/env zsh
# sqlcl.zsh - Oracle SQL Command Line utilities

# ═══════════════════════════════════════════════════
# SQLCL (Oracle SQL Command Line)
# ═══════════════════════════════════════════════════

sqlcl-connection() {
  local tns_name="$1"

  local user="${SQLCL_USERNAME}"
  if [[ -z "$user" ]]; then
    read -r "user?Enter username: "
  fi

  local password="${SQLCL_PASSWORD}"
  if [[ -z "$password" ]]; then
    read -rs "password?Enter database password: "
    echo ""  # New line after hidden input
  fi

  echo "${user}/\"${password}\"@${tns_name}"
}

sqlcl() {
  local tns_name="$1"

  if [[ -z "$tns_name" ]]; then
    local tnsnames=$(awk -F'=' '/^[A-Za-z0-9_]+[[:space:]]*=/ {gsub(/[[:space:]]/, "", $1); print $1}' ~/tnsnames.ora)
    tns_name=$(echo "$tnsnames" | tv)
  fi

  if [[ -z "$tns_name" ]]; then
    fail "No TNS name selected"
    return 1
  fi

  local connection_string=$(sqlcl-connection "$tns_name")
  "$HOME/bin/sqlcl/bin/sql" -S "$connection_string"
}
