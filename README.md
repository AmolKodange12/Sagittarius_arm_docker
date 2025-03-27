# Sagittarius Arm Docker

Dockerfile and instructions to control the **Sagittarius** robotic arm by NXROBO.

The [Sagittarius robotic arm](https://github.com/NXROBO/sagittarius_ws) only supports **Ubuntu 20.04** and **ROS Noetic** as the latest versions. To enable cross-compatibility, this Docker setup builds a container based on the official `ros-noetic` image from OSRF, allowing users to work with the robotic arm regardless of their native Ubuntu and ROS version.

## Prerequisites

Ensure you have Docker installed on your system. If not, follow the official [Docker installation guide](https://docs.docker.com/get-docker/).

## Setup Instructions

### 1. Build the Docker Image

Clone this repository and navigate into the directory:

```bash
git clone https://github.com/AmolKodange12/Sagittarius_arm_docker.git
cd Sagittarius_arm_docker
```

Now, build the Docker image:

```bash
docker build -t sagittarius_arm .
```

### 2. Run the Docker Container

Run the following command to start the container:

```bash
docker run -it --privileged \
    --net=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --device=/dev:/dev \
    --volume="/home/$USER/Sagittarius_arm_docker:/root/sagittarius_docker" \
    --name sagittarius_arm_container sagittarius_arm
```

To enter into the container once it's created.
The exec command can also be used to enter into a docker via multiple terminals.
```bash
docker start sagittarius_arm_container
docker exec -it sagittarius_arm_container bash
```


### 3. Enable GUI Support (Optional)

If using GUI applications, allow Docker to access your X server:

```bash
xhost +local:docker
```

### 4. Verify Device Connection

Ensure the correct device is being used. Replace `/dev/ttyACM0` with the actual device name if needed:

Use the following to find devices
```bash
ls /dev/tty*
```

Build a symbolic link to the correct device name the driver requires(right argument)
```bash
ln -s /dev/ttyACM0 /dev/sagittarius
```

### 5. Source ROS Setup

Run `sudo apt update` and follow the setup instructions from the [sagittarius_ws repository](https://github.com/NXROBO/sagittarius_ws) and add the sourcing commands to your `~/.bashrc` file:

```bash
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
echo "source /home/$USER/sagittarius_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

## Notes
- Replace `/dev/ttyACM0` with the actual device path of your Sagittarius robotic arm.
- The volume flag is optional; if you want to transfer files.
- The Docker container is set up to allow privileged access and host networking for proper communication with the robotic arm.
- If any issues arise with device permissions, consider adding your user to the `dialout` group:
  
  ```bash
  sudo usermod -aG dialout $USER
  ```
  
  Then, restart your system or log out and back in for the changes to take effect.
