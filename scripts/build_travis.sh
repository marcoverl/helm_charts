#!/bin/bash
RELEASE=stable
GH_PAGES=https://dodas-ts.github.io/helm_charts

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
done
