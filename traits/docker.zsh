pg_container_id() {
  ssh $1 'docker ps --format="{{.ID}} {{.Names}}" | grep _postgres | cut -c-12'
}

dump_db() {
  ssh $1 "docker exec -i $(pg_container_id $1) pg_dump -U app app"
}

alias ddb='dump_db'
