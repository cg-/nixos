  8 ### Useful Commands
  7
  6 #### Deploy Disko
  5 ```
  4 sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko/disko-zfs.nix     --argstr device /dev/nvme0n1
  3 ```
  2
  1 #### Install Flake
9   ```
  1 sudo nixos-install --flake .#vm
  2 ```
