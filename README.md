### Useful Commands
#### Deploy Disko
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko/disko-zfs.nix     --argstr device /dev/nvme0n1
```

#### Generate Hardware
```
sudo nixos-generate-config --root /mnt
```

#### Install Flake
```
sudo nixos-install --flake .#vm
```
