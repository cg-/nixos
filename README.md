### Useful Commands
#### Deploy Disko
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko/disko-zfs.nix     --argstr device /dev/nvme0n1
```

#### Install Flake
```
sudo nixos-install --flake .#vm
```
