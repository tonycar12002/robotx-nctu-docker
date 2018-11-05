docker build -t gazebo --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" .


docker build -t robotx-nctu -f Dockerfile .

nvidia-docker run -it --rm --env="DISPLAY" --name=gazebo --env="QT_X11_NO_MITSHM=1" --network host --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" gazebo # robotx-nctu-docker
