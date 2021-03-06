#!/usr/bin/env bash


function decrypt_keystore {

ENCRYPTED_KEYSTORE="keystore.enc"

KEYSTORE_FILE="circleci-demo-keystore.jks"

echo "$KEYSTORE_FILE should exist"

if [ ! -f "$KEYSTORE_FILE" ]; then
  echo "$KEYSTORE_FILE doesn't exist"
  echo "Decrypting $ENCRYPTED_KEYSTORE to generate $KEYSTORE_FILE"
  openssl aes-256-cbc -d -in $ENCRYPTED_KEYSTORE -out $KEYSTORE_FILE -k $ENV_DECRYPT_KEY
fi
}

function setup_signing_config {

KEYSTORE_FILE="circleci-demo-keystore.jks"
KEYSTORE_FILE_PATH=$(pwd)"/$KEYSTORE_FILE"

KEYSTORE_PROPERTIES="keystore.properties"

echo "keystore.properties should exist"

if [ ! -f "$KEYSTORE_PROPERTIES" ]; then
  echo "keystore.properties doesn't exist"

  echo "Creating keystore.properties file in project root directory..."
  touch keystore.properties

  echo "Writing signingConfigs for release builds to keystore.properties..."

  echo "storeFile=$KEYSTORE_FILE_PATH" >> "$KEYSTORE_PROPERTIES"
  echo "storePassword=$ENV_STORE_PASSWORD" >> "$KEYSTORE_PROPERTIES"
  echo "keyAlias=$ENV_KEY_ALIAS" >> "$KEYSTORE_PROPERTIES"
  echo "keyPassword=$ENV_KEY_PASSWORD" >> "$KEYSTORE_PROPERTIES"

fi
}