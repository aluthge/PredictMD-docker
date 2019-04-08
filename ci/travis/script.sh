#!/bin/bash

##### Beginning of file

set -ev

pwd
cd $TRAVIS_BUILD_DIR
pwd

make docker-purge-all

pwd
cd images
pwd
cd $IMAGE
pwd

make build
make test-all

if [[ "$TRAVIS_BRANCH" == "master" ]]
then
    if [[ "$TRAVIS_PULL_REQUEST" == "false" ]]
    then
        echo "$DOCKER_BOT_PASSWORD" | docker login -u "$DOCKER_BOT_USERNAME" --password-stdin
        make push
    else
        :
    fi
else
    if [[ "$TRAVIS_BRANCH" == "staging" ]]
    then
        if [[ "$TRAVIS_PULL_REQUEST" == "false" ]]
        then
            echo "$DOCKER_BOT_PASSWORD" | docker login -u "$DOCKER_BOT_USERNAME" --password-stdin
            make push
        else
            :
        fi
    else
        :
    fi
fi

pwd
cd $TRAVIS_BUILD_DIR
pwd

make docker-purge-all

##### End of file
