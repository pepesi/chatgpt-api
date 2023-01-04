#!/bin/bash

IMAGE_REPO=${IMAGE_REPO:-kubegems}

echo "build xvfb base image ..."
pushd ppxvfb-dockerfile
    docker build -t ppxvfb:v1 .
popd

echo "build chatgpt-api image ..."

docker build -t ${IMAGE_REPO}/chatgpt-api:latest .
[[ ! -z $NO_PUSH ]] && docker push ${IMAGE_REPO}/chatgpt-api:latest

echo "build proxy image ..."
pushd proxy
    docker build -t ${IMAGE_REPO}/chatgpt-api-proxy:latest .
    [[ ! -z $NO_PUSH ]] && docker push ${IMAGE_REPO}/chatgpt-api-proxy:latest
popd

echo "build feishubot image ..."
pushd feishubot
    docker build -t ${IMAGE_REPO}/chatgpt-api-feishubot:latest .
    [[ ! -z $NO_PUSH ]] && docker push ${IMAGE_REPO}/chatgpt-api-feishubot:latest
popd

