#!/bin/bash
apt-get update && \
apt-get -y install locales-all && \
# Uncomment en_US.UTF-8 for inclusion in generation
sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && \
# Generate locale
locale-gen && \
# Export env vars
echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc && \
echo "export LANG=en_US.UTF-8" >> ~/.bashrc && \
echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc
