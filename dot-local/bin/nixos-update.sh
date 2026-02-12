#!/usr/bin/env sh

set -e

flatpak update -y --noninteractive

# NixOS update
NIXOS_UPDATES=$(${HOME}/.local/bin/check-nixos-updates.sh)

if (( $NIXOS_UPDATES > 0 )); then
  cd ${HOME}/.config/nix
  nix flake update
  sudo nixos-rebuild switch --flake .
fi

