set -e

SRC=/home/app
WORKSPACE=/home/workspace

case $1 in

  build)
    echo "Building vite project"
    cd $SRC
    npm i
    npm exec vite -- build --assetsInlineLimit=0 --config /home/workspace/vite.config.ts
    cp $WORKSPACE/.dockerignore $SRC

    # pull custom files from source folder
    [ -f "$SRC/superstatic.json" ] || cp $WORKSPACE/superstatic.json $SRC
    ;;

  dev)
    cd $SRC
    npm i
    npm exec vite -- --host 0.0.0.0 --port $PORT
    ;;

  preview)
    cd $SRC
    echo "Running preview server"
    npm i
    npm exec vite -- preview --host 0.0.0.0 --port $PORT
    ;;

  *)
    sh /home/node/entrypoint.sh
    ;;
esac
