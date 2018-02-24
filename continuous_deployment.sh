#!/usr/bin/env bash

HELM_UPDATE_COMMIT_MESSAGE="${K8S_ENVIRONMENT_NAME} ${PROJECT_NAME} image update --no-deploy"

RES=0
ERRORS=""

cd /pwd

! gcloud container builds submit --substitutions _IMAGE_TAG=${IMAGE_TAG},_CLOUDSDK_CORE_PROJECT=${CLOUDSDK_CORE_PROJECT},_PROJECT_NAME=${PROJECT_NAME} \
                                 --config continuous_deployment_cloudbuild.yaml . \
    && ERRORS+="; failed to build image" && RES=1

cd /ops

! ./helm_update_values.sh "${B64_UPDATE_VALUES}" "${HELM_UPDATE_COMMIT_MESSAGE}" "${K8S_OPS_GITHUB_REPO_TOKEN}" \
                          "${OPS_REPO_SLUG}" "${OPS_REPO_BRANCH}" \
    && ERRORS+="; failed helm update values" && RES=1;

# ! ./helm_upgrade_external_chart.sh pipelines-jobs && ERRORS+="; failed helm upgrade" && RES=1;

echo "${ERRORS}"
exit $RES
