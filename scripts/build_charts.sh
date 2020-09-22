#!/bin/bash
RELEASE=stable
GH_PAGES=https://dodas-ts.github.io/helm_charts
COMMIT_MSG="Doc update"
CURRENT_BRANCH="master"

echo "Committing current changes"

git add -A
git commit -m "publishing charts"

chart_list=$(find . -name 'Chart.yaml')

echo "List of charts $chart_list"

BUILD_DIR=$(mktemp -d)

echo "Temp area: $BUILD_DIR"

cp -r ./ $BUILD_DIR/

for chart in $chart_list; do
    dirname=$(dirname ${chart})
    CHART_NAME="${dirname%"${dirname##*[!/]}"}" # extglob-free multi-trailing-/ trim
    CHART_NAME="${CHART_NAME##*/}"                  # remove everything before the last /

    echo "PROCESSING $CHART_NAME"

    helm lint ${dirname}
    helm package ${RELEASE}/${CHART_NAME}

    if [ -f index.yaml ]; then
        helm repo index  --url ${GH_PAGES} --merge index.yaml .
    else
        helm repo index  --url ${GH_PAGES} .
    fi

    mv ${CHART_NAME}*.tgz ${BUILD_DIR}/

done

mv ./index.yaml ${BUILD_DIR}/
git checkout gh-pages
cp -r ${BUILD_DIR}/* .
git add -A
git commit -m "${COMMIT_MSG}"
git push origin gh-pages
git checkout ${CURRENT_BRANCH}
