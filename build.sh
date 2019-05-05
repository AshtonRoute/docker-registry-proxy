#!/bin/bash -e

DOCKER_IMAGE="${1}"

function get_param_from_file() {
  local result=$(sed -n -r 's/'"${2}"'(.*)$/\1/p' < "${1}" | tr -d '[:space:]')
  echo -n "${result}"
}

if [[ -f '.env' ]];
then
  DOCKER_IMAGE=$(get_param_from_file '.env' '^DOCKER_IMAGE=')
fi

if [[ -z "${DOCKER_IMAGE}" ]];
then
  echo "Docker image not specified. Example: ${0} rpardini/docker-registry-proxy:latest"
  exit 1
fi

docker build --progress=plain -t "${DOCKER_IMAGE}" .
docker push "${DOCKER_IMAGE}"
