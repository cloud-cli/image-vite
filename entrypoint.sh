case $1 in

  build)
    cd /home/workspace;
    [ -f /home/app/index.html ] && cp /home/app/index.html /home/workspace/;
    npm run ci
    ;;

  dev)
    cd /home/workspace && npm run dev
    ;;

  preview)
    cd /home/workspace && npm run preview
    ;;

  *)
    sh /home/node/entrypoint.sh $@
    ;;
esac
