#!/bin/bash

set -e

export DOCKER_WORKSPACE_MOUNT_DIR="/media/sf_Codes"
export LATTICE_SRC_PATH="/workspace/lattice/lattice"
export DIEGO_RELEASE_PATH="/workspace/Diego/diego-release"
export CF_RELEASE_PATH="/workspace/CF/cf-release"
export DOCKER_IMAGE="cloudfoundry/lattice-pipeline"

CMD="echo Start to compile. && $LATTICE_SRC_PATH/compile $LATTICE_SRC_PATH/lattice-build $DIEGO_RELEASE_PATH $CF_RELEASE_PATH $LATTICE_SRC_PATH && echo Creating lattice.tgz && cd $LATTICE_SRC_PATH && tar cvzf lattice.tgz lattice-build  && rm -rf $LATTICE_SRC_PATH/lattice-build"

docker run -rm -a stdout -a stderr -w /workspace \
  -v ${DOCKER_WORKSPACE_MOUNT_DIR:-~/workspace/}:/workspace \
  -e LATTICE_SRC_PATH \
  -e DIEGO_RELEASE_PATH \
  -e CF_RELEASE_PATH \
  -e DRY_RUN \
  -e LATTICE_RELEASE_VERSION \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e GO_REVISION_DIEGO_RELEASE \
  -e GO_FROM_REVISION_DIEGO_RELEASE \
  -e GO_TO_REVISION_DIEGO_RELEASE \
  -e GO_REVISION_CF_RELEASE_RUNTIME_PASSED \
  -e GO_FROM_REVISION_CF_RELEASE_RUNTIME_PASSED \
  -e GO_TO_REVISION_CF_RELEASE_RUNTIME_PASSED \
  -e GO_REVISION_LATTICE \
  -e GO_FROM_REVISION_LATTICE \
  -e GO_TO_REVISION_LATTICE \
  -e GO_REVISION_LATTICE_CLI_GIT \
  -e GO_FROM_REVISION_LATTICE_CLI_GIT \
  -e GO_TO_REVISION_LATTICE_CLI_GIT \
  -e GO_TRIGGER_USER \
  -e GO_PIPELINE_LABEL \
  -e GO_PIPELINE_NAME \
  -e GO_STAGE_NAME \
  -e GO_JOB_NAME \
  $DOCKER_IMAGE \
  /bin/bash -c "$CMD"