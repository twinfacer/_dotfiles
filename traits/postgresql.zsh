# for postgresql DBMS

_exec_as_postgres() {
  sudo su - postgres -c "$1"
}

alias pge="_exec_as_postgres"

_create_pg_superadmin() {
  _exec_as_postgres "createuser -d -P -s"
}

alias pgu!="_create_pg_superadmin"
