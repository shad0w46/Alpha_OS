# AlphaOS v1.3 (COSMIC Edition)

AlphaOS v1.3 is a desktop operating system built on Debian, featuring the COSMIC desktop environment and powered by the Linux 7.3 kernel. It is designed to provide a fast, stable, and visually consistent computing experience suitable for everyday use, development, and general productivity.

---

## Overview

### Core System
- **Linux 7.3**: Delivers responsive hardware performance, broad peripheral compatibility, and reliable power management on modern laptops and desktop computers.
- **Debian Base**: Combines long-term system stability with full access to the Debian software repository ecosystem.
- **Modern Audio Stack**: Out-of-the-box PipeWire and WirePlumber integration for low-latency sound and automated device switching.
- **Integrated Connectivity**: Native Bluetooth device pairing and power profile controls.

---

## Downloads and Checksums

| File | Architecture | Size | SHA-256 Checksum |
| :--- | :--- | :--- | :--- |
| **`alphaos-cosmic-v-1.3.iso`** | x86_64 (amd64) | 2.7 GB | `b823b7d276c5bd91c87cb106666106b159961ad0a01d829e7d6d10dd47589058` |

---

## System Requirements

| Component | Minimum | Recommended |
| :--- | :--- | :--- |
| **Processor** | 64-bit Dual-Core (Intel or AMD) | 64-bit Quad-Core or higher |
| **Memory** | 4 GB RAM | 8 GB RAM or more |
| **Storage** | 20 GB free disk space | 40 GB SSD / NVMe |
| **Boot Media** | 4 GB USB flash drive | 8 GB USB 3.0 flash drive |
| **Firmware** | UEFI or Legacy BIOS | UEFI |

---

## Installation Guide

### 1. Create Installation Media
Write the ISO image to a USB flash drive using an imaging utility:
- **Cross-platform**: [balenaEtcher](https://etcher.balena.io/) or [Ventoy](https://www.ventoy.net/)
- **Windows**: [Rufus](https://rufus.ie/) (write in ISO or DD mode)
- **Linux (CLI)**:
  ```bash
  sudo dd if=alphaos-cosmic-v-1.3.iso of=/dev/sdX bs=4M status=progress oflag=sync
  ```
  *(Replace `/dev/sdX` with your USB target drive identifier)*

### 2. Boot the Live Environment
1. Insert the USB drive into the target computer and restart.
2. Enter the system boot selection menu (typically `F12`, `F11`, `F9`, or `Esc` during startup).
3. Select the USB storage device to boot into the live AlphaOS environment.
4. You can explore the system and test hardware compatibility without modifying your hard drive.

### 3. Install to Disk
1. Launch the **Install AlphaOS** program from the desktop or dock.
2. Select your language, keyboard layout, time zone, and disk partition preferences.
3. Create your user account and choose your credentials.
4. Once installation completes, reboot the system and remove the installation drive when prompted.

---

## Support and Links

- **Developer Site**: [rut-rupala.me](https://rut-rupala.me)
- **Issue Tracker**: Use the GitHub repository issue tracker for bug reports, hardware feedback, and feature inquiries.
