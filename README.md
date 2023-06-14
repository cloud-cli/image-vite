# Node.js image for Vite apps

This is a [Node.js](https://nodejs.org/) base image for [Cloudy](https://github.com/cloud-cli)

## Usage

Create a Dockerfile

```Dockerfile
FROM ghcr.io/cloud-cli/vite
ADD . /home/app
```

Build an app

```bash
docker build -t app-image .
docker run --rm app-image
```
