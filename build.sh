sudo docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) --build-arg passwd=<YOUR PASSWD> --build-arg display=$DISPLAY --tag ros:0.1.0 .
