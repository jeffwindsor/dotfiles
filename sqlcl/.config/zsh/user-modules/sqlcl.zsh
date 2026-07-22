#!/usr/bin/env zsh

# ═══════════════════════════════════════════════════
# FUNCTIONS
# ═══════════════════════════════════════════════════
SQLCL_SCHEMAS=(CJ CJ_PAYOUT FINANCIAL PARTNER_PAYMENT)

sqlcl() {
  local tns_name="$1"
  local schema="$2"

  if [[ -z "$tns_name" ]]; then
    local tnsnames=$(awk -F'=' '/^[A-Za-z0-9_]+[[:space:]]*=/ {gsub(/[[:space:]]/, "", $1); print $1}' ~/tnsnames.ora)
    tns_name=$(echo "$tnsnames" | tv)
  fi

  if [[ -z "$tns_name" ]]; then
    print_error "No TNS name selected"
    return 1
  fi

  if [[ -z "$schema" ]]; then
    schema=$(print -l $SQLCL_SCHEMAS | tv)
  fi
  if [[ -z "$schema" ]]; then
    print_error "No schema selected"
    return 1
  fi

  local connection_string
  connection_string=$(security find-generic-password -s "sqlcl-${tns_name}-${schema}" -a "connection" -w 2>/dev/null)

  if [[ -z "$connection_string" ]]; then
    print_error "No connection string stored for ${tns_name}/${schema}. Run: sqlcl-store ${tns_name} ${schema}"
    return 1
  fi

  "$HOME/.local/bin/sqlcl/bin/sql" -S "$connection_string"
}

sqlcl-store() {
  local tns_name="$1"
  local schema="$2"
  local connection_string="$3"

  if [[ -z "$tns_name" ]]; then
    read -r "tns_name?TNS name: "
  fi
  if [[ -z "$tns_name" ]]; then
    echo "TNS name cannot be empty" >&2
    return 1
  fi

  if [[ -z "$schema" ]]; then
    read -r "schema?Schema: "
  fi
  if [[ -z "$schema" ]]; then
    echo "Schema cannot be empty" >&2
    return 1
  fi

  if [[ -z "$connection_string" ]]; then
    read -r "connection_string?Connection string for ${tns_name}/${schema} (user/\"password\"@tns): "
  fi
  if [[ -z "$connection_string" ]]; then
    echo "Connection string cannot be empty" >&2
    return 1
  fi

  security add-generic-password -s "sqlcl-${tns_name}-${schema}" -a "connection" -w "${connection_string}" -U
}

# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias shopcart='sqlcl "SHOPCART"'
alias t5='sqlcl "TCJOWEB5"'
alias t1='sqlcl "TCJOWEB1"'
alias sql="cd $SOURCE/gitlab.cj.dev/jwindsor/sql"
