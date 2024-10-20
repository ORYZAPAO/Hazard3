FROM ubuntu:24.04
RUN apt update;\
    apt-get  -y --no-install-recommends install git openssh-client ca-certificates; \
    apt-get  -y --no-install-recommends install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev
RUN mkdir -p -m 0700 ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts 

WORKDIR /app
RUN git clone https://github.com/riscv/riscv-gnu-toolchain.git

WORKDIR /app/riscv-gnu-toolchain 
RUN ./configure --prefix=/opt/riscv --with-arch=rv32gc --with-abi=ilp32d; \
    make -j


