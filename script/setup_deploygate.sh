#!/usr/bin/env bash
./gradlew assembleRelease

APKPATH="app/build/outputs/apk/*release*.apk"

curl -F "file=@sample.apk" -F "token=$ENV_DEPLOYGATE_API" -F "message=Testing CircleCI integration with Deploygate" https://deploygate.com/api/users/fahimchoudhury/apps

