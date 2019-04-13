# ssh-gui-ros-docker

Support SSH & GUI for ROS environment (Kinetic)



## Set-up

<br/>

### build.sh

set your password in `build.sh`

```bash
sudo docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) --build-arg passwd=<YOUR PASSWD> --build-arg display=$DISPLAY --tag ros:0.1.0 .
```

<br/>

### attach_ssh.sh

set your user account and container ip that gotting from executing inspection.sh

<br/>

## Installation

Run the script in the following order:

```bash
> sh build.sh
> sh build-xauth-file.sh
> sh run.sh # after should be check container running or not
> sh inspection.sh # after should set up  attach_ssh.sh
> sh attach.sh
```


