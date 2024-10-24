#!/bin/bash
riscv32-unknown-linux-gnu-g++      -c                             $1.cpp
riscv32-unknown-linux-gnu-objcopy  -O binary --only-section=.text $1.o  $1.img
