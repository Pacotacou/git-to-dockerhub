#!/bin/sh

# Fail on error
set -e

# Check input
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <github_user/repo> <dockerhub_user/repo>"
  exit 1
fi

GITHUB_REPO=$1
DOCKERHUB_REPO=$2
REPO_NAME=$(basename "$GITHUB_REPO")

# Login to Docker Hub
echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin

# Clone the GitHub repository
git clone "https://github.com/$GITHUB_REPO.git"

# Build and push
cd "$REPO_NAME"
docker build -t "$DOCKERHUB_REPO" .
docker push "$DOCKERHUB_REPO"
