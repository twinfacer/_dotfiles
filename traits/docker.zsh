pg_container_id() {
  ssh $1 'docker ps --format="{{.ID}} {{.Names}}" | grep _postgres | cut -c-12'
}

dump_db() {
  ssh $1 "docker exec -i $(pg_container_id $1) pg_dump -U app app"
}

apply_db() {
  psql -h localhost -d $1 -U odin < ~/projects/$1.sql
}

alias ddb='dump_db'
alias udb='apply_db'

alias dps='docker ps'
alias dps!='watch -n 1 docker ps'
alias de='docker exec -it'

alias dsl='docker service logs -t'
alias dsu='docker service update'
