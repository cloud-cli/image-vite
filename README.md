# Node.js image for Vite apps

This is a [Node.js](https://nodejs.org/) base image for [Cloudy](https://github.com/cloud-cli)

## Usage

First, create a project:

- `main.ts`:

```
import { createApp } from "vue";
import App from "./App.vue";

createApp(App).mount("#app");
```

- `index.html`
```html
<div id="app"></div>
<script type="module" src="src/main.ts"></script>
```

- `App.vue`
```
<template>
  <div>Hello, {{ name }}!</div>
</template>

<script setup>
const name = 'world';
</script>
```

Then run a build

```sh
docker run --rm -v $PWD:/home/app ghcr.io/cloud-cli/vite:latest build
```

## Creating a container

After build, create a Dockerfile

```Dockerfile
FROM ghcr.io/cloud-cli/node:latest
ADD . /home/app
```

Then build the image:

```
docker build -t my-app .
```

The app is now ready to run or publish!

## Run app preview

```sh
docker run --rm -p 80:8080 -e PORT=8080 -v $PWD:/home/app ghcr.io/cloud-cli/vite:latest preview
```
