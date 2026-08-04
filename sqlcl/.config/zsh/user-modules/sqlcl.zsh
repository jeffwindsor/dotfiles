#!/usr/bin/env zsh

sqlcl() {
  local tns_name="$1"
  local name="$2"

  if [[ -z "$tns_name" ]]; then
    local tnsnames
    tnsnames=$(awk -F'=' '/^[A-Za-z0-9_]+[[:space:]]*=/ {gsub(/[[:space:]]/, "", $1); print $1}' ~/tnsnames.ora)
    tns_name=$(echo "$tnsnames" | tv)
  fi

  if [[ -z "$tns_name" ]]; then
    echo "No TNS name selected" >&2
    return 1
  fi

  if [[ -z "$name" ]]; then
    local names
    names=$(security dump-keychain | grep -o '"svce"<blob>="sqlcl-'"${tns_name}"'-[^"]*"' | sed 's/.*"sqlcl-'"${tns_name}"'-//;s/"//')
    name=$(echo "$names" | tv)
  fi

  if [[ -z "$name" ]]; then
    echo "No connection name selected" >&2
    return 1
  fi

  local connection_string
  connection_string=$(security find-generic-password -s "sqlcl-${tns_name}-${name}" -a "connection" -w 2>/dev/null)

  if [[ -z "$connection_string" ]]; then
    echo "No connection stored for ${tns_name}-${name}. Run: sqlcl-store ${tns_name} ${name} <user> <password>" >&2
    return 1
  fi

  "$HOME/.local/bin/sqlcl/bin/sql" -S "$connection_string"
}

sqlcl-store() {
  local tns_name="$1"
  local name="$2"
  local user="$3"
  local password="$4"

  if [[ -z "$tns_name" ]]; then
    read -r "tns_name?TNS name: "
  fi
  [[ -z "$tns_name" ]] && { echo "TNS name cannot be empty" >&2; return 1; }

  if [[ -z "$name" ]]; then
    read -r "name?Name: "
  fi
  [[ -z "$name" ]] && { echo "Name cannot be empty" >&2; return 1; }

  if [[ -z "$user" ]]; then
    read -r "user?User: "
  fi
  [[ -z "$user" ]] && { echo "User cannot be empty" >&2; return 1; }

  if [[ -z "$password" ]]; then
    read -rs "password?Password: "
    echo
  fi
  [[ -z "$password" ]] && { echo "Password cannot be empty" >&2; return 1; }

  security add-generic-password -s "sqlcl-${tns_name}-${name}" -a "connection" -w "${user}/\"${password}\"@${tns_name}" -U
}

sqlcl-import() {
  local csvfile="$1"

  if [[ -z "$csvfile" ]]; then
    read -r "csvfile?CSV file path: "
  fi
  [[ ! -f "$csvfile" ]] && { echo "File not found: ${csvfile}" >&2; return 1; }

  local count=0 errors=0

  while IFS=',' read -r name tns user password; do
    name="${name//[[:space:]]/}"
    tns="${tns//[[:space:]]/}"
    user="${user//[[:space:]]/}"
    password="${password//[[:space:]]/}"

    if security add-generic-password -s "sqlcl-${tns}-${name}" -a "connection" -w "${user}/\"${password}\"@${tns}" -U 2>/dev/null; then
      echo "Stored: ${tns}-${name}"
      (( count++ ))
    else
      echo "Failed: ${tns}-${name}" >&2
      (( errors++ ))
    fi
  done < <(tail -n +2 "$csvfile")

  echo "Done: ${count} stored, ${errors} errors"
}

# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias shopcart='sqlcl "SHOPCART"'
alias t5='sqlcl "TCJOWEB5"'
alias t1='sqlcl "TCJOWEB1"'
alias sql="cd $SOURCE/gitlab.cj.dev/jwindsor/sql"
