# NixOS dual system installation

## Entering LiveCD and Mount Disk

Follow steps in
[https://nixos-cn.org/tutorials/installation/Subsystem.html](https://nixos-cn.org/tutorials/installation/Subsystem.html)
 

## Generate defualt `configuration.nix` and `hardware-configuration.nix`


```
nixos-generate-config --root /mnt
```

Remain `imports` part and `system.stateVersion` part in `configuration.nix`.

Modify `options` parameters for `fileSystem` in `hardware-configuration.nix` following parameters you used to mount disks. Can have a look with the example in the [https://nixos-cn.org/tutorials/installation/Subsystem.html#%E5%88%86%E5%8C%BA%E4%B8%8E%E6%A0%BC%E5%BC%8F%E5%8C%96](above link).

## Use the repository

```
cd /mnt/etc/nixos  # enter the config path
nix-shell -p git   # download git
git clone https://github.com/idiig/nixos-gpd  # clone the repo
rm nixos-gpd/configuration.nix nixos-gpd/hardware-configuration.nix  # delete the dublicated configs
mv nixos-gpd/* .   # copy configs to the path
rm -rf nixos-gpd   # delete repo
sudo nixos-install # install nixos 
``` 

## Add user

```
nixos-enter
passwd root  # reset root password
useradd -m -G wheel <user-name>  # add user
passwd <user-name>  # user password
exit
reboot
```

## Switch using flake

```
sh switch.sh
```
