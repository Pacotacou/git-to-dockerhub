#!/bin/bash
# Script to clone a GitHub repository, build Docker image, and publish to Docker Hub
# Usage: ./builder.sh <github_username/repo> <dockerhub_username/image_name> [<tag>]

set -e  # Exit immediately if a command exits with a non-zero status

# Check if required arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <github_username/repo> <dockerhub_username/image_name> [<tag>]"
  echo "Example: $0 mluukkai/express_app mluukkai/testing latest"
  exit 1
fi

# Assign arguments to variables
GITHUB_REPO=$1
DOCKER_DESTINATION=$2
TAG=${3:-latest}  # Use 'latest' as default if no tag is provided

# Extract GitHub username and repository name
GITHUB_USERNAME=$(echo $GITHUB_REPO | cut -d '/' -f1)
REPO_NAME=$(echo $GITHUB_REPO | cut -d '/' -f2)

# Extract Docker Hub username and image name
DOCKER_USERNAME=$(echo $DOCKER_DESTINATION | cut -d '/' -f1)
DOCKER_IMAGE_NAME=$(echo $DOCKER_DESTINATION | cut -d '/' -f2)

# Full GitHub URL
GITHUB_URL="https://github.com/$GITHUB_REPO.git"

# Create a temporary directory for cloning
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Function to clean up temporary directory
cleanup() {
  echo "Cleaning up temporary directory..."
  rm -rf "$TEMP_DIR"
}

# Register the cleanup function to run on exit
trap cleanup EXIT

echo "Step 1: Cloning repository $GITHUB_URL..."
git clone "$GITHUB_URL" "$TEMP_DIR"
cd "$TEMP_DIR"

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
  echo "Error: Dockerfile not found in the repository root!"
  exit 1
fi

# Full image name with tag
FULL_IMAGE_NAME="$DOCKER_DESTINATION:$TAG"

echo "Step 2: Building Docker image as $FULL_IMAGE_NAME..."
docker build -t "$FULL_IMAGE_NAME" .

echo "Step 3: Logging in to Docker Hub..."
echo "Please enter your Docker Hub password when prompted:"
docker login -u "$DOCKER_USERNAME"

echo "Step 4: Pushing image to Docker Hub..."
docker push "$FULL_IMAGE_NAME"

echo "Step 5: Logging out from Docker Hub..."
docker logout

echo "Successfully built and published $FULL_IMAGE_NAME to Docker Hub!"