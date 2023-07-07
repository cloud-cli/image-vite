set -xe

case $1 in

  build)
    SRC=/home/workspace/src
    echo "Building vite project"
    cd /home/workspace
    node merge-packages.js
    cp superstatic.json $SRC
    cp .dockerignore $SRC
    [ -f $SRC/index.html ] && cp $SRC/index.html /home/workspace/
    [ -f $SRC/manifest.json ] && cp $SRC/manifest.json /home/workspace/
    npm run ci || exit 1
    [ -d $SRC/assets ] && cp -r $SRC/assets/* /home/workspace/dist/
    mv /home/workspace/dist $SRC/
    ls -al $SRC
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
