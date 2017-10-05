#!/usr/bin/env bash

if [ "$CIRCLE_BRANCH" == "release" ]; then
  echo "Currently on release branch"
  echo "Creating signed release apk..."
  ./gradlew assembleRelease

  RELEASE_APK=$(find ./app/build/outputs/apk/ -name '*release*apk')

  if [ -f $RELEASE_APK ]; then
    echo "Release APK found"
    echo "Uploading to Deploygate..."
    curl -F "file=@$RELEASE_APK" -F "token=$ENV_DEPLOYGATE_API" -F "message=Version 2.0.0 released" https://deploygate.com/api/users/$ENV_DEPLOYGATE_USER/apps
  else
    echo "Release APK not found, aborting..."
  fi
else
  echo "Not release branch so not deploying"
fi





