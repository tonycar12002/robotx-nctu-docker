FROM d3637042/ros-kinetic-gazebo-gym-nvidia9.0

LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}


RUN apt-get update && apt-get install -y -qq g++ cmake xterm libfltk1.3-dev freeglut3-dev libpng12-dev libjpeg-dev > /dev/null && \
	apt-get install -y -qq libxft-dev libxinerama-dev libtiff5-dev  > /dev/null

RUN git clone https://github.com/ARG-NCTU/moos-ivp-nctu.git moos-ivp && \
	cd moos-ivp && \
	./build-moos.sh && \
	./build-ivp.sh 



ARG ssh_prv_key
ARG ssh_pub_key
RUN apt-get update && \
    apt-get install -y \
        git \
        openssh-server \
        libmysqlclient-dev

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Add the keys and set permissions
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub


ENV HOME /root
WORKDIR ${HOME}

ENV PATH="/root/moos-ivp/bin:${PATH}"

# Setup the ZED SDK
RUN apt-get update --fix-missing
RUN apt-get install lsb-release wget less udev sudo apt-transport-https apt-utils -y
RUN wget -O ZED_SDK_Linux_Ubuntu16.run https://download.stereolabs.com/zedsdk/2.4/ubuntu_cuda9 
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
RUN chmod +x ZED_SDK_Linux_Ubuntu16.run ; ./ZED_SDK_Linux_Ubuntu16.run silent


RUN apt-get update > /dev/null && apt-get install -y ros-kinetic-geographic-msgs ros-kinetic-geodesy libpcap-dev > /dev/null

#RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash && \
#	git clone git@github.com:RobotX-NCTU/robotx_nctu.git && \
#	cd robotx_nctu/catkin_ws && catkin_make --pkg robotx_msgs && catkin_make && \
#	cd ../moos/ && ./build.sh"

RUN apt-get update > /dev/null && apt-get install -y net-tools network-manager && apt-get install ros-kinetic-teleop-twist-keyboard
 > /dev/null

ENV PATH="/root/robotx_nctu/moos/bin:${PATH}"

# Remove SSH keys
#RUN rm -rf /root/.ssh/

EXPOSE 9000
EXPOSE 9100
