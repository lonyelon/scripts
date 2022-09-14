#!/bin/sh

# Day2 installation scripts. Run this after the archinstall installer to
# recreate my setup, data not included.
#
# USAGE:
# curl https://raw.githubusercontent.com/lonyelon/scripts/main/installation/day2.sh | sh /dev/stdin USERNAME
#
# Made by SERGIO MIGUÉNS IGLESIAS <sergio@lony.xyz> for personal use, 2022.

user=$1
homedir=`getent passwd $user | cut -d: -f6`

#                                                     INSTALLATION PREREQUISITES
################################################################################

pacman -Syyu fzf git rsync

#                                                                     XORG SETUP
################################################################################

drivers='
    xf86-video-amdgpu
    xf86-video-ati
    xf86-video-nouveau
    xf86-video-intel
    xf86-video-fbdev
    xf86-video-vesa
'

option=$(echo "$drivers" | grep '[a-z]' | tr -d ' ' \
    | fzf --header='Select a GPU driver for the system:')
[ -z "$option" ] && option="xf86-video-fbdev"
pacman -S xorg-server $option

#                                                             SUCKLESS UTILITIES
################################################################################

git clone https://github.com/lonyelon/dwm.git /tmp/dwm
git clone https://github.com/lonyelon/dmenu.git /tmp/dmenu
git clone https://github.com/lonyelon/st.git /tmp/st
cd /tmp/dwm
# TODO Select diff files to apply
make install
cd /tmp/dmenu
make install
cd /tmp/st
make install

#                                                                          EMACS
################################################################################

pacman -S emacs
#pacman -S ripgrep
git clone --depth 1 https://github.com/doomemacs/doomemacs $homedir/.emacs.d
$homedir/.emacs.d/bin/doom install

#                                                                       OPENDOAS
################################################################################

pacman -S opendoas
echo 'permit keepenv persist :wheel' > /etc/doas.conf
pacman -Rns sudo || exit
ln -s /bin/doas /bin/sudo

#                                                                            YAY
################################################################################

git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
cd /opt/yay-git
makepkg -si

#                                                                 CUSTOM SCRIPTS
################################################################################

git clone https://github.com/lonyelon/scripts.git $homedir/sh

#                                                                      SSH SETUP
################################################################################

su $user -c ssh-keygen
sed -i 's/^X11Forwarding yes/X11Forwarding no/'
sed -i 's/^UsePAM yes/UsePam no/'

#                                                    MISC UTILITIES INSTALLATION
################################################################################

packages='
    vim
    unison
    bc
    man-db man-pages
    keepassxc sxiv
    wget
    hledger
    task
'

pacman -S $packages
