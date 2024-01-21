set -xe

SRC=/home/workspace/src

case $1 in

  build)
    echo "Building vite project"
    cd /home/workspace
    node merge-packages.js
    cp .dockerignore $SRC

    [ -f "$SRC/superstatic.json" ] || cp superstatic.json $SRC

    for file in index.html manifest.json superstatic.json; do
      [ -f "$SRC/$file" ] && cp $SRC/$file /home/workspace/
    done

    npm run ci || exit 1
    [ -d $SRC/assets ] && cp -r $SRC/assets/* /home/workspace/dist/
    mv /home/workspace/dist $SRC/
    ls -al $SRC
    ;;

  dev)
    cd /home/workspace
    [ -d $SRC/assets ] && ln -s $SRC/assets /home/workspace/assets
    [ -f $SRC/index.html ] && cp $SRC/index.html /home/workspace/
    npm run dev
    ;;

  preview)
    cd /home/workspace;
    node merge-packages.js
    echo "Running preview server"
    npm i && npm run preview -- --host 0.0.0.0 --port $PORT
    ;;

  *)
    sh /home/node/entrypoint.sh $@
    ;;
esac
