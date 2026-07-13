#!/usr/bin/bash
# Пересборка initramfs под новое ядро (форсированная загрузка nvidia
# уже включена nvidia-install.sh через 99-nvidia.conf).
set -eoux pipefail

KERNEL_VERSION=$(rpm -q --queryformat="%{evr}.%{arch}" kernel-longterm-core)

# /root -> /var/roothome, а /var во время сборки — пустой tmpfs;
# без каталога dracut-install падает с ERROR: installing '/root'
mkdir -p /var/roothome

# модуль ostree включается только по явному запросу (--add), без него
# initramfs не выполнит ostree-prepare-root и switch-root в /sysroot упадёт
export DRACUT_NO_XATTR=1
dracut --no-hostonly --kver "${KERNEL_VERSION}" --reproducible -v --add ostree -f \
    "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"
chmod 0600 "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"
