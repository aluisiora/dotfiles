#!/usr/bin/env sh

cd ${HOME}/.config/nix

# Create a temporary directory to avoid messing up your actual flake.lock
TEMP_DIR=$(mktemp -d)
cp flake.nix flake.lock "$TEMP_DIR"
cd "$TEMP_DIR" || exit

# Update the lockfile (quietly)
nix flake update --quiet 2>/dev/null

# Compare the current system to the "new" evaluation
# We use 'nix store diff-closures' to see the changed paths
# We grep for '+' to count only new/upgraded packages
NIX_UPDATES=$(nix store diff-closures /run/current-system .#nixosConfigurations."$(hostname)".config.system.build.toplevel 2>/dev/null | grep -c '^+')

FLATPAK_UPDATES=$(flatpak remote-ls --updates --columns=application | wc -l)

# Output the raw number
TOTAL_UPDATES=$((NIX_UPDATES + FLATPAK_UPDATES))
echo "$TOTAL_UPDATES" | xargs

# Cleanup
rm -rf "$TEMP_DIR"
