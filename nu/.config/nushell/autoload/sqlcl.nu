
def sqlcl-connection [tns_name: string] {
  let user = input -d "cj" "Enter username: " 
  let password = input --suppress-output "Enter database password: "
  
  $"($user)/\"($password)\"@($tns_name)"
}

def sqlcl-execute [connection_string: string, sql: string, exit_on_completion: bool] {
  let sql = $"SET PAGESIZE 0
              SET LINESIZE 32767
              SET SQLFORMAT CSV
              SET FEEDBACK OFF
              SET HEADING ON
              SET ECHO OFF
              WHENEVER SQLERROR EXIT SQL.SQLCODE
              WHENEVER OSERROR EXIT FAILURE
              ($sql)"

  if $exit_on_completion {
    let sql = $"($sql)
                EXIT"
  }
  
  $sql | run-external ($env.HOME | path join "bin" "sqlcl" "bin" "sql") "-S" $connection_string
}

def sqlcl-file [tns_name: string, filename: string, exit_on_completion: bool = true] {
  let sql = (open ($filename | path expand))
  let connection_string = sqlcl-connection $tns_name
  
  sqlcl-execute $connection_string $sql true
}

def sqlcl-open [tns_name: string] {
  let connection_string = sqlcl-connection $tns_name
  run-external ($env.HOME | path join "bin" "sqlcl" "bin" "sql") "-S" $connection_string
}

def sqlcl [] {
  let tnsname_list = "awk -F'=' '/^[A-Za-z0-9_]+[[:space:]]*=/ {gsub(/[[:space:]]/, \"\", \$1); print \$1}' tnsnames.ora"
  let tns_name = tv --source-command $tnsname_list
  let connection_string = sqlcl-connection $tns_name
  run-external ($env.HOME | path join "bin" "sqlcl" "bin" "sql") "-S" $connection_string
}

alias shopcart = sqlcl-open "SHOPCART"
alias t5 = sqlcl-open "TCJOWEB5"
alias t1 = sqlcl-open "TCJOWEB1"

