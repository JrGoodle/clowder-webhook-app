#!/usr/bin/env bash

BUILD_NUMBER="$1"
# COMMIT="$2"

rm -rf ./cc-test-reporter coverage
curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
chmod +x ./cc-test-reporter
aws s3 sync "s3://clowder-coverage/coverage/$BUILD_NUMBER" coverage/
./cc-test-reporter sum-coverage --output - --parts 8 coverage/codeclimate.*.json | \
  ./cc-test-reporter upload-coverage --input -

# if [ ! -d "$DIRECTORY" ]; then
#     git clone git@github.com:JrGoodle/clowder.git
# fi
# pushd clowder || exit 1
# git fetch
# git checkout $COMMIT
# popd || exit 1
# cd coverage || exit 1
# coverage combine --rcfile='../clowder/.coveragerc'
# rm -rf '../Public/coverage'
# coverage html -d '../Public/coverage' --rcfile='../clowder/.coveragerc'
