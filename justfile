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

# Garbage collect old generations (keeps last 7 days by default)
gc days="7":
    sudo nix profile wipe-history --older-than {{days}}d
    sudo nix-collect-garbage --delete-older-than {{days}}d

# Run git diff against the current configuration
diff:
    git diff

# reset
# Reset repository to the last commit
reset:
    @printf "Are you sure you want to reset the repository to the last commit? Type 'yes' to proceed, 'no' to cancel: "
    @read confirmation; \
    if [ "$confirmation" = "yes" ]; then \
        git reset --hard HEAD; \
    fi