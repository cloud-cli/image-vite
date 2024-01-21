set -xe

SRC=/home/workspace/src

case $1 in

  build)
    echo "Building vite project"
    cd /home/workspace
    node merge-packages.js

    # add
    cp .dockerignore $SRC
    [ -f "$SRC/superstatic.json" ] || cp superstatic.json $SRC

    # pull custom files from source folder
    for file in index.html manifest.json superstatic.json; do
      [ -f "$SRC/$file" ] && cp $SRC/$file /home/workspace/
    done

    # sort out extra assets
    npm run ci || exit 1
    [ -d $SRC/assets ] && cp -r $SRC/assets /home/workspace/dist/assets
    ls -al /home/workspace/*
    mv /home/workspace/dist $SRC/
    ls -al $SRC/dist
    ;;

  dev)
    cd /home/workspace
    [ -d $SRC/assets ] && ln -s $SRC/assets /home/workspace/assets
    [ -f $SRC/index.html ] && rm /home/workspace/index.html && ln -s $SRC/index.html /home/workspace/
    ls -al /home/workspace
    npm i
    npm run dev
    ;;

  preview)
    cd /home/workspace;
    node merge-packages.js
    echo "Running preview server"
    npm i
    npm run preview
    ;;

  *)
    sh /home/node/entrypoint.sh $@
    ;;
esac
