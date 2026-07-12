ARG FEDORA_VERSION=44
ARG FEDORA_IMAGE_NAME=kinoite
ARG KERNEL_FLAVOR=longterm-6.18

FROM ghcr.io/ublue-os/akmods-nvidia-lts:${KERNEL_FLAVOR}-${FEDORA_VERSION} AS akmods-nvidia

FROM scratch AS ctx
COPY build_files/base /base

FROM quay.io/fedora-ostree-desktops/${FEDORA_IMAGE_NAME}:${FEDORA_VERSION}

RUN --mount=type=tmpfs,dst=/boot \
    --mount=type=tmpfs,dst=/var \
    --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=bind,from=akmods-nvidia,src=/kernel-rpms,dst=/tmp/kernel-rpms \
    --mount=type=bind,from=akmods-nvidia,src=/rpms,dst=/tmp/akmods-rpms \
    /ctx/base/00-kernel.sh && \
#    /ctx/base/01-nvidia.sh && \
    /ctx/base/02-initramfs.sh

RUN --mount=type=tmpfs,dst=/run \
    bootc container lint
