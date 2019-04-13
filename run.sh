sudo docker run -i -t -d -P \
	-e DISPLAY=unix$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
	-e XAUTHORITY=/tmp/.docker.xauth \
	--name ros ros:0.1.0
