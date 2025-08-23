
# query current alias
def query-aliases [query] {
  scope aliases
  | where {|r| $r.expansion =~ $query or $r.name =~ $query}
}
# alias ar = alias-query
alias qa = alias-query

# query current commands
def query-commands [query] {
  scope commands
  | where type == "custom"
  | where name like $query
}
alias qa = commands-query

def query-everything [query] {
  {
    aliases: (query-aliases $query),
    commands: (query-commands $query)
  }
}
alias qq = query-everything

