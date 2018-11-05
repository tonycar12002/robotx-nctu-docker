# robotx-nctu-docker
This docker contains following packages
* ROS
* Gazebo
* MOOS-IvP
* robotx_gazebo
* [gym-gazebo](https://github.com/d3637042/gym-gazebo)
* ZED SDK


## How to get docker images
There are 2 ways to get docker images

1. build from dockfer file
```
$ docker build -t robotx-nctu -f Dockerfile .
```
2. get docker from docker hub
```
$ docker pull tonycar12002/robotx-nctu
```

## How to run
1. Clone our robotx_nctu repo to your computer
```
$ cd 
$ cd git clone https://github.com/RobotX-NCTU/robotx_nctu.git
```

2. Run the docker
```
$ xhost +local:root
$ sudo service nvidia-docker start
$ sudo nvidia-docker run -it --rm -v /home/[your username]:/hostname --env="DISPLAY" --name=robotx-nctu --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --privileged robotx-nctu
```

3. Build the repo
```
container# cd /hostname/robotx_nctu/catkin_ws
container# catkin_make --pkg --robotx_msgs
container# catkin_make
```

## Test the code
1. Test ZED sensors
This [website](https://stackoverflow.com/questions/24225647/docker-a-way-to-give-access-to-a-host-usb-or-serial-device) teaches how to access to a host usb device. ZED is --device=/dev/video0
```
container# byobu
(first page)
container# cd /hostname/robotx_nctu/catkin_ws
container# source devel/setup.bash
container# roslaunch zed_wrapper zed.launch 
(second page)
container# rviz
```


## Still Working On
This is the beta version of our docker file. We found that "nsplug" will cause some fatal errors, we are still fixing the problems. 

## Contacts
If you have any question please contact to us.
* Tony Hsiao <tonycar12002@gmail.com>