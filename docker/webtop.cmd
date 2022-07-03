docker rm -f webtop
docker run --name webtop --rm -it -p 3000:3000 --shm-size="8gb" ghcr.io/linuxserver/webtop
