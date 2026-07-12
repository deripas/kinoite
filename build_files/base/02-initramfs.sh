#!/usr/bin/bash
# Пересборка initramfs под новое ядро (форсированная загрузка nvidia
# уже включена nvidia-install.sh через 99-nvidia.conf).
set -eoux pipefail

KERNEL_VERSION=$(rpm -q --queryformat="%{evr}.%{arch}" kernel-longterm-core)

export DRACUT_NO_XATTR=1
dracut --no-hostonly --kver "${KERNEL_VERSION}" --reproducible -v -f \
    "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"
chmod 0600 "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"
