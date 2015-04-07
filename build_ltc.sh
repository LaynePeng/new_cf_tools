#!/bin/bash

set -e

export DOCKER_WORKSPACE_MOUNT_DIR="/media/sf_Codes"
export LATTICE_SRC_PATH="/workspace/lattice/lattice"
export DIEGO_RELEASE_PATH="/workspace/Diego/diego-release"
export CF_RELEASE_PATH="/workspace/CF/cf-release"
export DOCKER_IMAGE="cloudfoundry/lattice-pipeline"

CMD="echo Start to compile. && $DIEGO_RELEASE_PATH/scripts/update && source $LATTICE_SRC_PATH/lattice-pipeline/helpers/build_ltc_helpers && setup_go_env && construct_ltc_gopath && run_unit_tests && git_describe_lattice && go_build_ltc && generate_ltc_tarball $LATTICE_SRC_PATH"

docker run --rm -a stdout -a stderr -w /workspace \
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