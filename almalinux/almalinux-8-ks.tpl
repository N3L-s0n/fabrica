# authentication options
auth --useshadow --passalgo=sha512

# partition options
autopart --type=lvm --fstype=ext4

# bootloader options
bootloader --append="crashkernel=auto" --location=mbr

# clear all partitions prior, and create default disk labels
clearpart --all --initlabel

# non-interactive installation
cmdline

# accept End User License Agreement (EULA)
eula --agreed

# enable firewall
firewall --enabled --service=ssh

# disable initial setup
firstboot --disabled

# Keyboard configuration
keyboard --vckeymap=us --xlayouts='us'
lang en_US

# Reboot after install
reboot

# Network configuration
network --bootproto=dhcp --device=link --activate 

# Root user password
rootpw --plaintext ${username}

# SELinux configuration
selinux --enforcing

# Dont configure X on the system
skipx
zerombr
# Create new user

user --name=${username} --plaintext --password=${username}

# Services 
services --enabled=NetworkManager,sshd,chronyd

# Repositories
repo --name=base --baseurl=http://ftp.sakura.ad.jp/almalinux/8.7/BaseOS/x86_64/os/ --cost=100
repo --name=appstream --baseurl=http://ftp.sakura.ad.jp/almalinux/8.7/AppStream/x86_64/os/ --cost=1000

# SOFTWARE SELECTION
%packages
@^minimal-environment
%end

# POST INSTALLATION SCRIPT
%post --nochroot --log=/mnt/sysimage/root/ks-post.log
    echo "packer ALL=(ALL) NOPASSWD: ALL" >> /mnt/sysimage/etc/sudoers.d/packer
%end