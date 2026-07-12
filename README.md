# Kinoite

Custom Fedora Kinoite bootc image built on top of the official Fedora Kinoite image.

## Features

-   Fedora Kinoite 44
-   KDE Plasma
-   Linux longterm 6.18 kernel
-   NVIDIA 580 driver (prebuilt akmods from uBlue)
-   Immutable bootc/OSTree system
-   Ready for Flatpak applications

## About this project

This project started as a personal experiment to learn the Fedora bootc ecosystem and image-based Linux distributions.

The initial goal is simple: build a Fedora Kinoite image for older hardware using the long-term 6.18 kernel together with the NVIDIA 580 driver, while staying as close as possible to upstream Fedora.

This is **not** intended to compete with projects like Aurora or Bazzite. Those projects provide complete desktop distributions with many additional features and extensive infrastructure.

Instead, this repository focuses on:

- learning how bootc images are built;
- composing a custom Fedora Kinoite image from upstream components;
- keeping the image small, understandable and easy to modify;
- experimenting with different kernels and hardware configurations.

## Build

``` bash
podman build -t kinoite .
```

## Why not Aurora or Bazzite?

Aurora and Bazzite are excellent projects, but they target a much broader audience and include many features that I don't currently need.

For learning purposes, I wanted a smaller project built directly on top of the official Fedora Kinoite image while reusing the published uBlue akmods images for kernel and NVIDIA support.

The goal is to understand the bootc ecosystem rather than maintain another Fedora remix.

