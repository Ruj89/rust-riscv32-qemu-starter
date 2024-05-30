#!/usr/bin/env sh

curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y
. "$HOME/.cargo/env"
rustup default nightly
rustup target add riscv32imac-unknown-none-elf

mkdir tools
cd tools

# Install QEMU.
sudo apt -y install qemu-system-misc

# Download and extract the RISC-V GNU Compiler Toolchain.
ARCHIVE_DATE="2024.04.12"
ARCHIVE_FILENAME="riscv32-glibc-ubuntu-22.04-gcc-nightly-$ARCHIVE_DATE-nightly.tar.gz"
ARCHIVE_URL="https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/$ARCHIVE_DATE/$ARCHIVE_FILENAME"
wget $ARCHIVE_URL
tar -xf $ARCHIVE_FILENAME
mv riscv riscv-gnu-toolchain

cd ..

# Set up a disk for QEMU.
dd if=/dev/zero of=qemu.dsk bs=1M count=32
