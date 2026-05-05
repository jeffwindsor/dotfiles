#!/usr/bin/env zsh

SQLCL_SCHEMAS=(CJ CJ_PAYOUT FINANCIAL PARTNER_PAYMENT)

# ═══════════════════════════════════════════════════
# FUNCTIONS
# ═══════════════════════════════════════════════════
sqlcl-connection() {
  local tns_name="$1"
  local default_user="$2"

  local user="${SQLCL_USERNAME:-$default_user}"
  if [[ -z "$user" ]]; then
    read -r "user?Enter username: "
  else
    local input
    read -r "input?Enter username [$user]: "
    user="${input:-$user}"
  fi

  local password="${SQLCL_PASSWORD}"
  if [[ -z "$password" ]]; then
    read -rs "password?Enter database password: "
    echo ""
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
    print_error "No TNS name selected"
    return 1
  fi

  local db_user
  local schema=$(print -l $SQLCL_SCHEMAS | tv)
  if [[ -n "$schema" ]]; then
    db_user=$(security find-generic-password -s "sqlcl-${schema}" -a "db_user" -w 2>/dev/null)
  fi

  local connection_string=$(sqlcl-connection "$tns_name" "$db_user")
  "$HOME/.local/bin/sqlcl/bin/sql" -S "$connection_string"
}

sqlcl-store() {
  local schema="$1"
  local db_user="$2"

  if [[ -z "$schema" ]]; then
    read -r "schema?Schema: "
  fi
  if [[ -z "$schema" ]]; then
    echo "Schema cannot be empty" >&2
    return 1
  fi

  if [[ -z "$db_user" ]]; then
    read -r "db_user?DB user for ${schema}: "
  fi
  if [[ -z "$db_user" ]]; then
    echo "DB user cannot be empty" >&2
    return 1
  fi

  security add-generic-password -s "sqlcl-${schema}" -a "db_user" -w "${db_user}" -U
}

# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias shopcart='sqlcl "SHOPCART"'
alias t5='sqlcl "TCJOWEB5"'
alias t1='sqlcl "TCJOWEB1"'
alias sql="cd $SOURCE/gitlab.cj.dev/jwindsor/sql"
