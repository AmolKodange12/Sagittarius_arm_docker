# Sagittarius_arm_docker
Dockerfile and instructions to control the Sagittarius robot arm by NXROBO

The robotic arm Sagittarius by NXROBO(https://github.com/NXROBO/sagittarius_ws) only supports Ubuntu 20.04 and ROS noetic at the latest.
Therefore this dockerfile allows the user to build a docker container which builds on the official ros-noetic image from OSRF.

The dockerfile and the instructions should allow the user to work with the robotic arm regardless of their native Ubuntu and ROS version.


Steps
dockerfile
run command:
docker run -it --privileged     --net=host     --env="DISPLAY"     --env="QT_X11_NO_MITSHM=1"     --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw"     --device=/dev/ttyACM0     --volume="/home/$USER/sagittarius_folder:/root/sagittarius_docker"     --name sagittarius_arm_container sagittarius_arm

xhost +local:docker
replace device field with what the arm is called on the host

follow instructions from the sagittarius_ws repo
add sourcing commands to ~/.bashrc

ln -s /dev/ttyACM0 /dev/sagittarius
replace left with actual device name 


