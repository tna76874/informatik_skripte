#!/bin/bash

while getopts ":b:" opt; do
  case ${opt} in
    b )
      deploy_branch=$OPTARG
      ;;
    \? )
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

deploy() {
  if [ -n "$deploy_branch" ]; then
    ./generate_markdown.sh
    mike deploy --branch ${deploy_branch} --update-aliases --push ${REPO_COMMIT} latest || mike deploy --branch ${deploy_branch} --push ${REPO_COMMIT} latest
    mike set-default --branch ${deploy_branch} --push latest
  else
    mkdocs serve
  fi
}

export build_doc_date=$(date -u '+%d.%m.%Y')
export REPO_COMMIT=$(git log -1 --pretty=format:%H)

deploy


