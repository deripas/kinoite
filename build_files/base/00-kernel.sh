#!/usr/bin/bash
# Замена стокового ядра Fedora на kernel-longterm из кэша akmods.
set -eoux pipefail

for pkg in kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-tools kernel-tools-libs; do
    if rpm -q "${pkg}" >/dev/null 2>&1; then
        rpm --erase "${pkg}" --nodeps
    fi
done
rm -rf /usr/lib/modules

# Ядро уже подписано ключами ublue (dual-sign) для secure boot
dnf5 -y install \
    /tmp/kernel-rpms/kernel-longterm-[0-9]*.rpm \
    /tmp/kernel-rpms/kernel-longterm-core-*.rpm \
    /tmp/kernel-rpms/kernel-longterm-modules-*.rpm
