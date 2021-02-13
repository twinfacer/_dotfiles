# ArchUp

- Install barebone Archlinux
```shell
  # Enable NTP (Network Time Protocol)
  timedatectl set-ntp true
  # TODO: Partitioning && FS creation
  fdisk ...
  mkfs.ext4 <root-partition>
  # TODO: Swap setup
  mkswap <swap-partition>
  swapon <swap-partition>
  # TODO: Mount root partition
  mount <root-partition> /mnt
  # Install selected packages into newly mounted "root" filesystem
  pacstrap /mnt base linux linux-firmware git curl htop
  # Generate an fstab file
  genfstab -U /mnt >> /mnt/etc/fstab
  # Chroot into new system
  arch-chroot /mnt
  # TODO: Setup timezone
  # ASK: -- Region
  # ASK: -- City
  ln -sf /usr/share/zoneinfo/<Region>/<City> /etc/localtime
  hwclock --systohc
  # TODO: Localization
  # TODO: Create the hostname file
  # Set root password
  passwd
  # TODO: bootloader (grub)
  exit
  umount -R /mnt
  reboot
```
- Install DE (xfce4) + DE Plugins (xfce4-dockbarx-plugin)
  ```shell
    yay xfce4 xfce4-dockbarx-plugin
  ```
  - Post Install DE
    - Install replacer wm - compton?
    - Setup xfce4-panel
    - Setup xfce4-terminal
    - Setup keybindings
    - Setup wallpaper, wm-theme, fonts
- Install Packages
  - Console Tools
    - yay, git, zsh, curl, jq, htop, tmux
  - GUI Apps
    - atom, firefox, libre-office, deluge, meld, vlc, gimp, postman-bin

- Install .dotfiles
```
curl -L "https://git.io/fNdqS" | zsh
```
