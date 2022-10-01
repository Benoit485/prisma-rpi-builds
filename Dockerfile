FROM debian:buster

RUN dpkg --add-architecture armhf

ENV ARMV7_UNKNOWN_LINUX_GNUEABIHF_OPENSSL_LIB_DIR=/usr/lib/arm-linux-gnueabihf
ENV ARMV7_UNKNOWN_LINUX_GNUEABIHF_OPENSSL_INCLUDE_DIR=/usr/include/arm-linux-gnueabihf/openssl

ENV PATH=/root/.cargo/bin:$PATH

RUN apt-get update && apt-get -y install wget curl git make build-essential clang libz-dev libz-dev:armhf libsqlite3-dev openssl libssl-dev libssl-dev:armhf pkg-config gzip mingw-w64 g++ libmpc-dev libmpfr-dev libgmp-dev gcc-arm-linux-gnueabihf libc6-dev-armhf-cross g++-arm-linux-gnueabihf libmagic-dev

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add armv7-unknown-linux-gnueabihf
RUN rustup component add clippy

ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc
ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_RUNNER="/linux-runner armv7"
ENV CC_armv7_unknown_linux_gnueabihf=arm-linux-gnueabihf-gcc
ENV CXX_armv7_unknown_linux_gnueabihf=arm-linux-gnueabihf-g++
ENV QEMU_LD_PREFIX=/usr/arm-linux-gnueabihf
ENV LIBZ_SYS_STATIC=1 
