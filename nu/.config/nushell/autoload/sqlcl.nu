
def sqlcl-connection [tns_name: string] {
  let user = if ($env.SQLCL_USERNAME? | is-empty) {
    input -d "cj" "Enter username: "
  } else {
    $env.SQLCL_USERNAME
  }
  
  let password = if ($env.SQLCL_PASSWORD? | is-empty) {
    input --suppress-output "Enter database password: "
  } else {
    $env.SQLCL_PASSWORD
  }
  
  $"($user)/\"($password)\"@($tns_name)"
}

# def sqlcl-file [tns_name: string, filename: string, exit_on_completion: bool = true] {
#   let sql = (open ($filename | path expand))
#   let connection_string = sqlcl-connection $tns_name
#   $sql | run-external ($env.HOME | path join "bin" "sqlcl" "bin" "sql") "-S" $connection_string
# }

def sqlcl [] {
  let tnsname_list = "awk -F'=' '/^[A-Za-z0-9_]+[[:space:]]*=/ {gsub(/[[:space:]]/, \"\", \$1); print \$1}' ~/tnsnames.ora"
  let tns_name = tv --source-command $tnsname_list
  let connection_string = sqlcl-connection $tns_name
  run-external ($env.HOME | path join "bin" "sqlcl" "bin" "sql") "-S" $connection_string
}

alias shopcart = sqlcl-open "SHOPCART"
alias t5 = sqlcl-open "TCJOWEB5"
alias t1 = sqlcl-open "TCJOWEB1"

