### Useful Commands
#### Deploy Disko
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko/disko-zfs-1drive.nix --argstr device /dev/nvme0n1
```

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --argstr deviceX "/dev/nvme0n1" --argstr deviceY "/dev/nvme1n1" ./disko-config-2drives.nix
```

#### Generate Hardware
```
sudo nixos-generate-config --root /mnt
```

#### Install Flake
```
sudo nixos-install --flake .#NAME
```
