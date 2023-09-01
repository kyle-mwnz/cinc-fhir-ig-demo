#!/usr/bin/env bash

git config user.name Kyle Martin
git config user.email kyle-mwnz@github.com

# get the current IG version number
CURRENT_VERSION=$(yq '.version' sushi-config.yaml)
# get the current IG version number in a IG builder URL friendly format (remove .)
CURRENT_VERSION_URL_FRIENDLY=$(echo "$CURRENT_VERSION" | tr -d .)

echo Current IG version number is $CURRENT_VERSION, url friendly version is $CURRENT_VERSION_URL_FRIENDLY

# if this version does not yet exist in the history.md file, add it
if [ $(grep -c "$CURRENT_VERSION" input/pagecontent/history.md) -eq 0 ]
then
  # add an entry to the history.md log file with the new version
  echo Adding $CURRENT_VERSION to history.md
  sed -i "10i - [$CURRENT_VERSION](./branches/$CURRENT_VERSION_URL_FRIENDLY)" input/pagecontent/history.md

  # add the history.md update to a git branch, so the entry is stored
  git push origin --delete update/$CURRENT_VERSION_URL_FRIENDLY || true
  git checkout -b update/$CURRENT_VERSION_URL_FRIENDLY
  git add input/pagecontent/history.md
  git commit -m "[no ci] Updated IG history.md"
  git push --set-upstream origin update/$CURRENT_VERSION_URL_FRIENDLY
  gh pr create --head update/$CURRENT_VERSION_URL_FRIENDLY --base master --title "Updated IG history" --body "Updated IG history"
fi

# create a new release branch for the current version and push it
git fetch
git push origin --delete $CURRENT_VERSION_URL_FRIENDLY || true
git checkout -b $CURRENT_VERSION_URL_FRIENDLY
git push --set-upstream origin $CURRENT_VERSION_URL_FRIENDLY

# request the FHIR IG auto-builder to deploy the release branch
echo Request the FHIR IG auto-builder to deploy the release branch
curl -X POST "https://us-central1-fhir-org-starter-project.cloudfunctions.net/ig-commit-trigger" \
  -H "Content-type: application/json" \
  --data "{\"ref\": \"refs/heads/$CURRENT_VERSION_URL_FRIENDLY\", \"repository\": {\"full_name\": \"kyle-mwnz/cinc-fhir-ig-demo\"}}"
