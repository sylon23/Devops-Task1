#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install wget
wget -qO- https://get.docker.com/ | sh
exit
