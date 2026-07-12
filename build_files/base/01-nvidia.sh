#!/usr/bin/bash
# Установка nvidia 580 (negativo17) из кэша akmods-nvidia-lts.
# nvidia-install.sh поставляется внутри образа akmods и сам ставит
# userspace-RPMы + kmod-nvidia, собранный под kernel-longterm.
set -eoux pipefail

# MULTILIB=1: mesa i686 + 32-битные библиотеки nvidia (нужно для Steam)
IMAGE_NAME=kinoite AKMODNV_PATH=/tmp/akmods-rpms MULTILIB=1 \
    /tmp/akmods-rpms/ublue-os/nvidia-install.sh

rm -f /usr/share/vulkan/icd.d/nouveau_icd.*.json

mkdir -p /usr/lib/bootc/kargs.d
tee /usr/lib/bootc/kargs.d/00-nvidia.toml <<EOF
kargs = ["rd.driver.blacklist=nouveau", "modprobe.blacklist=nouveau", "nvidia-drm.modeset=1", "initcall_blacklist=simpledrm_platform_driver_init"]
EOF

# Публичный ключ, которым подписаны kmod'ы, — для enroll в MOK при secure boot
mkdir -p /etc/pki/akmods/certs
curl --retry 3 -Lo /etc/pki/akmods/certs/akmods-ublue.der \
    https://github.com/ublue-os/akmods/raw/refs/heads/main/certs/public_key.der
