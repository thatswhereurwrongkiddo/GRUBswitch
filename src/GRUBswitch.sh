#! /usr/bin/env bash

#MIT License

#Copyright (c) 2017 Andrei Shevchuk
#Copyright (c) 2019 thatswhereurwrongkiddo

#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

#NOTE#
#portions of this file have been copied from install.sh
#written by Andrei Shevchuk (shvchk on GitHub)


# Detect distro and set GRUB location and update method
GRUB_DIR='grub'
UPDATE_GRUB=''

if [ -e /etc/os-release ]; then

    source /etc/os-release

    if [[ "$ID" =~ (debian|ubuntu|solus) || \
          "$ID_LIKE" =~ (debian|ubuntu) ]]; then

        UPDATE_GRUB='update-grub'

    elif [[ "$ID" =~ (arch|gentoo) || \
            "$ID_LIKE" =~ (archlinux|gentoo) ]]; then

        UPDATE_GRUB='grub-mkconfig -o /boot/grub/grub.cfg'

    elif [[ "$ID" =~ (centos|fedora|opensuse) || \
            "$ID_LIKE" =~ (fedora|rhel|suse) ]]; then

        GRUB_DIR='grub2'
        UPDATE_GRUB='grub2-mkconfig -o /boot/grub2/grub.cfg'
    fi
fi

#copy grub_th1 to GRUB themes directory
echo 'Copying grub_th1 to GRUB themes directory'
cd grub_th && cp -r grub_th1 /boot/${GRUB_DIR}/themes

#switch themes
echo 'Switching themes in GRUBswitch grub_th directory'
mv grub_th1 grub_th2.tmp
mv grub_th2 grub_th1
mv grub_th2.tmp grub_th2

#cd into GRUB themes directory and intialize grub_th1 as new current GRUBswitch theme
echo 'Changing into GRUB themes directory'
echo 'Initializing grub_th1 as new current GRUB theme'
cd /boot/${GRUB_DIR}/themes && rm -R GRUBswitch
mv grub_th1 GRUBswitch

echo 'Removing other themes from GRUB config'
sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub

echo 'Making sure GRUB uses graphical output'
sudo sed -i 's/^\(GRUB_TERMINAL\w*=.*\)/#\1/' /etc/default/grub

echo 'Removing empty lines at the end of GRUB config' # optional
sudo sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' /etc/default/grub

echo 'Adding new line to GRUB config just in case' # optional
echo | sudo tee -a /etc/default/grub

echo 'Adding theme to GRUB config'
echo "GRUB_THEME=/boot/${GRUB_DIR}/themes/GRUBswitch/theme.txt" | sudo tee -a /etc/default/grub

echo 'Updating GRUB'
if [[ $UPDATE_GRUB ]]; then
    eval sudo "$UPDATE_GRUB"
else
    cat << '    EOF'
    --------------------------------------------------------------------------------
    Cannot detect your distro, you will need to run `grub-mkconfig` (as root) manually.

    Common ways:
    - Debian, Ubuntu, Solus and derivatives: `update-grub` or `grub-mkconfig -o /boot/grub/grub.cfg`
    - RHEL, CentOS, Fedora, SUSE and derivatives: `grub2-mkconfig -o /boot/grub2/grub.cfg`
    - Arch, Gentoo and derivatives: `grub-mkconfig -o /boot/grub/grub.cfg`
    --------------------------------------------------------------------------------
    EOF
fi
