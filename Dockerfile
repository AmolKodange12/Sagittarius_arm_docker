# Use the official OSRF ROS Noetic image
FROM osrf/ros:noetic-desktop-full

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install required packages
RUN apt-get update && apt-get install -y \
    git \
    usbutils \
    qrencode \
    udev \
    cmake \
    libssl-dev \
    pkg-config \
    libusb-1.0-0-dev \
    && rm -rf /var/lib/apt/lists/*

# Ensure /etc/udev/rules.d exists
RUN mkdir -p /etc/udev/rules.d

# Clone librealsense repository
RUN git clone https://github.com/IntelRealSense/librealsense.git

# Build and install librealsense
RUN cd /librealsense && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && make install && \
    apt update && apt upgrade	

RUN cd /home && \
    git clone https://github.com/NXROBO/sagittarius_ws.git

# Set entrypoint to bash
CMD ["/bin/bash"]

