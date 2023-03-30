#!/usr/bin/bash

# add current user to docker group
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
