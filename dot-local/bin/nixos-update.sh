#!/usr/bin/env sh

set -e

cd ${HOME}/.config/nix
nix flake update
sudo nixos-rebuild switch --flake .
