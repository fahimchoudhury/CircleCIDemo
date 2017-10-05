#!/usr/bin/env bash


function decrypt_keystore {
ENCRYPTED_KEYSTORE="keystore.enc"
export ENCRYPTED_KEYSTORE

KEYSTORE_FILE=$CIRCLE_WORKING_DIRECTORY"/circleci-demo-keystore.jks"
export KEYSTORE_FILE

echo "circleci-demo-keystore.jks should exist at $KEYSTORE_FILE"

if [ ! -f "$KEYSTORE_FILE" ]; then
  echo "$KEYSTORE_FILE doesn't exist"
  echo "Decrypting $ENCRYPTED_KEYSTORE to generate $KEYSTORE_FILE"
  openssl aes-256-cbc -d -in $ENCRYPTED_KEYSTORE -out circleci-demo-keystore.jks -k $ENV_DECRYPT_KEY
fi
}

function setup_signing_config {
KEYSTORE_FILE=$CIRCLE_WORKING_DIRECTORY"/circleci-demo-keystore.jks"
export KEYSTORE_FILE

KEYSTORE_PROPERTIES=$CIRCLE_WORKING_DIRECTORY"/keystore.properties"
export KEYSTORE_PROPERTIES

echo "keystore.properties should exist at $KEYSTORE_PROPERTIES"

if [ ! -f "$KEYSTORE_PROPERTIES" ]; then
  echo "keystore.properties doesn't exist"

  echo "Creating keystore.properties file..."
  touch $KEYSTORE_PROPERTIES

  echo "Writing signingConfigs for release builds to keystore.properties..."
  echo "storeFile=$KEYSTORE_FILE" >> $KEYSTORE_PROPERTIES
  echo "storePassword=$ENV_STORE_PASSWORD" >> $KEYSTORE_PROPERTIES
  echo "keyAlias=$ENV_KEY_ALIAS" >> $KEYSTORE_PROPERTIES
  echo "keyPassword=$ENV_KEY_PASSWORD" >> $KEYSTORE_PROPERTIES

fi
}