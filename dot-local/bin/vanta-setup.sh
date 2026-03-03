#!/usr/bin/env bash

cd /tmp
curl --location --output google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome.deb -y
bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/main/install-linux.sh)"
