# Justfile for NixOS Flake Management

# Default recipe: list available commands
default:
    @just --list

# Update flake inputs (lockfile)
update:
    nix flake update

# Switch NixOS configuration for the current host or a specific one
# Usage: just switch [hostname]
switch host="metal":
    sudo nixos-rebuild switch --flake ".#{{host}}"

# Test NixOS configuration without making it the default boot entry
# Usage: just test [hostname]
test host="metal":
    sudo nixos-rebuild test --flake ".#{{host}}"

# Build NixOS configuration without switching
# Usage: just build [hostname]
build host="metal":
    sudo nixos-rebuild build --flake ".#{{host}}"

# Garbage collect old generations (keeps last 7 days by default)
gc days="7":
    sudo nix profile wipe-history --older-than {{days}}d
    sudo nix-collect-garbage --delete-older-than {{days}}d

# Run git diff against the current configuration
diff:
    git diff

# Format all nix files using alejandra or nixfmt if available
fmt:
    nixfmt **/*.nix || alejandra **/*.nix

# Deploy Disko configuration for a 1-drive setup
# Usage: just disko-1dev /dev/nvme0n1
disko-1dev device="/dev/nvme0n1":
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko/disko-zfs-1drive.nix --argstr device "{{device}}"

# Deploy Disko configuration for a 2-drive setup
# Usage: just disko-2dev /dev/nvme0n1 /dev/nvme1n1
disko-2dev deviceX="/dev/nvme0n1" deviceY="/dev/nvme1n1":
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --argstr deviceX "{{deviceX}}" --argstr deviceY "{{deviceY}}" ./disko/disko-zfs-2drive.nix

# Install a new NixOS host flake
# Usage: just install hostname device
install host device:
    sudo nixos-install --flake ".#{{host}}"
