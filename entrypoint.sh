case $1 in

  build)
    cd /home/workspace;
    node merge-packages.js
    cp superstatic.json /home/app/
    [ -f /home/app/index.html ] && cp /home/app/index.html /home/workspace/;
    npm run ci || exit 1;
    [ -d /home/app/assets ] && cp -r /home/app/assets /home/workspace/dist/;
    ;;

  dev)
    cd /home/workspace && npm run dev
    ;;

  preview)
    cd /home/workspace;
    node merge-packages.js
    npm i && npm run preview --host 0.0.0.0 --port $PORT
    ;;

  *)
    sh /home/node/entrypoint.sh $@
    ;;
esac
