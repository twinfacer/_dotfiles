# Sync time
timedatectl set-ntp true

# Partitions
cfdisk

# Create filesystems
mkfs.ext4 /dev/sda1

# Swap
mkswap /dev/sda2
swapon /dev/sda2

# Mount filesystem
mount /dev/sda1 /mnt

# Install packages
pacstrap /mnt base base-devel grub git zsh sudo

# Generate fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot
arch-chroot /mnt

# Timezone setup
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

# Locales
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Network
echo "wanderworld" > /etc/hostname

# root password
passwd

# grub setup
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# POSTINSTALL

# user
useradd -m -G=wheel -s=/usr/bin/zsh wanderer
passwd wanderer

# passwordless sudo
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# yaourt
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
