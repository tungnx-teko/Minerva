upload() {
    PACKAGE_NAME=$1
    GITHUB_TOKEN=$2
    ASSET_URL=$3
    
    file="./Outputs/${PACKAGE_NAME}.zip"

    response=$(curl \
        --request POST \
        --header "Accept: application/vnd.github.v3+json" \
        --header "Authorization: token ${GITHUB_TOKEN}" \
        --header "Content-Type: $(file -b --mime-type ${file})" \
        --data-binary @${file} \
        "${ASSET_URL}?name=$(basename ${file})" \
    )

  echo ${response}
}

GITHUB_TOKEN=$1
RELEASE_FILE_NAME=$2
RELEASE_VERSION=$3
RELEASE_CHANGE_LOG=$4
RELEASE_URL=$5

#releaseInfo=`cat ./release/release.json`
#releaseUrl=$(echo ${releaseInfo}  | python -c 'import sys, json; print json.load(sys.stdin)["release_url"]')
releaseData='{"body": "'"$RELEASE_CHANGE_LOG"'", "tag_name": "'"${RELEASE_FILE_NAME}-${RELEASE_VERSION}"'", "draft": false, "prerelease": false, "name": "'"${RELEASE_FILE_NAME} ${RELEASE_VERSION}"'", "target_commitish": "master"}'

echo $releaseData

releaseResponse=$(curl \
  --request POST \
  --header "Authorization: token ${GITHUB_TOKEN}" \
  --header 'Content-Type: application/json; charset=utf-8' \
  --data "${releaseData}" \
  "${RELEASE_URL}" \
)

echo $releaseResponse

uploadUrl=$(echo ${releaseResponse}  | python -c 'import sys, json; print json.load(sys.stdin)["upload_url"]')
uploadUrl=${uploadUrl//"{?name,label}"/""}

upload ${RELEASE_FILE_NAME} ${GITHUB_TOKEN} ${uploadUrl}
