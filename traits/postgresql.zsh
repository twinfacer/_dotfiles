# for postgresql DBMS
_exec_as_postgres() { sudo su - postgres -c "$1" }
_create_pg_superadmin() { _exec_as_postgres "createuser -d -P -s $1" }

alias pge="_exec_as_postgres"
alias pgu!="_create_pg_superadmin"
