#!/bin/bash
#create path for new kernel
mkdir conf5
cd conf5
#install wget, gcc, flex, bison, openssl-devel, bc, elfutils-libelf-devel, perl
yum install -y wget gcc flex bison openssl-devel bc elfutils-libelf-devel perl
#download kernel sources
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.3.8.tar.xz
#extract sources
tar -xvf linux-5.3.8.tar.xz
#change path to unpacked kernel sources
cd linux-5.3.8/
#copy curent config to .config
cp /boot/config-3.10.0-957.12.2.el7.x86_64 .config
#do oldconfig with defaults
yes "" | make oldconfig
#start make kernel with 8 jobs
make -j 8
#make modules with 8 jobs
make -j 8 modules
#install modules
make modules_install
#install kernel
make install
# Remove older kernels (Only for demo! Not Production!)
rm -f /boot/*3.10*
# Update GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."
# Reboot VM
shutdown -r now
