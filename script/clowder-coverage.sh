#!/usr/bin/env bash

BUILD_NUMBER="$1"
# COMMIT="$2"

updateCodeClimateCoverage() {
    rm -rf ./cc-test-reporter coverage
    curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
    chmod +x ./cc-test-reporter
}

updateCodeClimateCoverage
aws s3 sync "s3://clowder-coverage/coverage/$BUILD_NUMBER" coverage/
./cc-test-reporter sum-coverage --output - --parts 8 coverage/codeclimate.*.json | \
  ./cc-test-reporter upload-coverage --input -

