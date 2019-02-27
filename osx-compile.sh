#!/bin/bash

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  mkdir -p /tmp/ros2_ws/src
  cp -r /tmp/moveit2 /tmp/ros2_ws/src
  cd /tmp/ros2 && wget wget https://raw.githubusercontent.com/AcutronicRobotics/moveit2/master/external-repos.repos
  vcs import src < external-repos.repos
  colcon build --merge-install
fi