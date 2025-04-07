# GitHub to Docker Hub Builder

A simple shell script that automates the process of cloning a GitHub repository, building a Docker image from a Dockerfile in the root directory, and publishing it to Docker Hub.

## Prerequisites

- Git installed and configured
- Docker installed and configured
- Docker Hub account
- Bash shell environment

## Installation

1. Clone or download this repository
2. Make the script executable:
   ```bash
   chmod +x builder.sh
   ```

## Usage

```bash
./builder.sh <github_username/repo> <dockerhub_username/image_name> [<tag>]
```

### Parameters

- `<github_username/repo>`: The GitHub repository in the format `username/repository`
- `<dockerhub_username/image_name>`: The Docker Hub destination in the format `username/image-name`
- `[<tag>]`: (Optional) The tag for the Docker image. Defaults to `latest` if not specified

### Example

```bash
./builder.sh mluukkai/express_app mluukkai/testing
```

This will:
1. Clone the GitHub repository `https://github.com/mluukkai/express_app.git`
2. Build a Docker image using the Dockerfile in the repository root
3. Push the image to Docker Hub as `mluukkai/testing:latest`

To specify a specific tag:

```bash
./builder.sh mluukkai/express_app mluukkai/testing v1.0
```

## Features

- Automatic temporary directory creation and cleanup
- Error handling to ensure each step completes successfully
- Automatic tag defaulting to `latest` if not specified
- Checks for Dockerfile existence in the repository root

## Troubleshooting

- Ensure you have proper permissions to clone the GitHub repository
- Make sure your Docker Hub credentials are correct
- Verify that a Dockerfile exists in the root of the GitHub repository
- Check your network connection if pushing to Docker Hub fails
