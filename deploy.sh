#!/bin/bash

TEX_VERSION=""
TEX_COMMIT=""

while getopts ":b:v:c:" opt; do
  case ${opt} in
    b )
      deploy_branch=$OPTARG
      ;;
    v )
      TEX_VERSION=$OPTARG
      ;;
    c )
      TEX_COMMIT=$OPTARG
      ;;
    \? )
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


deploy() {
  if [ -n "$deploy_branch" ]; then
    mike deploy --branch ${deploy_branch} --update-aliases --push ${TEX_VERSION} ${TEX_COMMIT} latest || mike deploy --branch ${deploy_branch} --push ${TEX_VERSION} ${TEX_COMMIT} latest
    mike set-default --branch ${deploy_branch} --push latest
  else
    mkdocs serve
  fi
}

export build_doc_date=$(date -u '+%d.%m.%Y')

deploy


