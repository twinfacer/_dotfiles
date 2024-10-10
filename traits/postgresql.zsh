# Aliases for postgresql DBMS

_exec_as_postgres() { sudo su - postgres -c "$1" }
_create_pg_superadmin() { _exec_as_postgres "createuser -d -P -s $1" }

# Exec command as postgres user
alias pge="_exec_as_postgres"

# Create new pg admin user
alias pgu!="_create_pg_superadmin"

# Initialize postgresql database
alias pginit="su - postgres -c \"initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data' &>/dev/null\""
