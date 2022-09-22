USERNAME=user
HOSTNAME=host
TZ="Europe/Moscow"
# BAREBONE ARCHLINUX INSTALL
# 1) Select drive to use
# 2) Partition drive && swap
# 3) Select timezone
# 4) Select locale
# 4) Select hostname
# sync time
timedatectl set-ntp true
# partitions
# TODO: Automate
cfdisk
# Create filesystems
# TODO: Can warry
mkfs.ext4 /dev/sda1
# Swap
# TODO: Can warry
mkswap /dev/sda2
swapon /dev/sda2
# Mount filesystem
mount /dev/sda1 /mnt
# Install packages
# TODO: Probably some packages can be moved to 'future' stages
pacstrap /mnt base base-devel grub # like here: git zsh sudo tmux
# Generate fstab file
genfstab -U /mnt >> /mnt/etc/fstab
# Chroot
arch-chroot /mnt
# Timezone setup
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
hwclock --systohc
# Locales
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
# Network
echo $HOSTNAME > /etc/hostname
# root password
passwd
# grub setup
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
# POSTINSTALL
# user
useradd -m -G=wheel -s=/usr/bin/zsh $USERNAME
passwd $USERNAME

# passwordless sudo
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
