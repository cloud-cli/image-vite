case $1 in

  build)
    echo "Building vite project"
    cd /home/workspace
    node merge-packages.js
    cp superstatic.json /home/app/
    cp .dockerignore /home/app/
    [ -f /home/app/index.html ] && cp /home/app/index.html /home/workspace/
    [ -f /home/app/manifest.json ] && cp /home/app/manifest.json /home/workspace/
    npm run ci || exit 1
    [ -d /home/app/assets ] && cp -r /home/app/assets/* /home/workspace/dist/
    mv /home/workspace/dist /home/app
    ls -al /home/app
    ;;

  dev)
    cd /home/workspace && npm run dev
    ;;

  preview)
    cd /home/workspace;
    node merge-packages.js
    echo "Running preview server"
    npm i && npm run preview --host 0.0.0.0 --port $PORT
    ;;

  *)
    sh /home/node/entrypoint.sh $@
    ;;
esac
