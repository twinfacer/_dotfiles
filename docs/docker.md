tag = <image-name>:<version>

docker
  run <image-name|tag> <command>
    -d
    -i
    -t
    -p <host-port:container-port>
    -v <host-path/volume:container-path>
    -e <env-var-name=env-var-val>
    --entrypoint <cmd>
    --network=(bridge|none|host)
  ps
    -a
  stop <container-name|container-id>
  rm <container-name|container-id>
  images
  rmi <image-name>
  pull <image-name>
  exec <container-name|container-id> <command>
    -i
    -t
  attach <container-name|container-id>
  inspect <container-name|container-id>
  logs <container-name|container-id>
  build <path-to-Dockerfile|.>
    -t <image-name>
  push <image-name>
  history <image-name>
  network
    create
    ls

Dockerfile
<insruction> <arguments>
  FROM
  RUN
  COPY
  ENTRYPOINT|CMD
