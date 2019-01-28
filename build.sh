#!/bin/bash -xe

# arm-none-eabi-gcc -x assembler-with-cpp -c -O0 -mcpu=cortex-m4 -mthumb -Wall linker_scripts/vtable_stm32l496xx.s -o vtable_stm32l496xx.o
# arm-none-eabi-gcc -x assembler-with-cpp -c -O0 -mcpu=cortex-m4 -mthumb -Wall linker_scripts/boot_stm32l496xx.s -o boot_stm32l496xx.o
# arm-none-eabi-gcc -c -mcpu=cortex-m4 -mthumb -Wall -g -fmessage-length=0 --specs=nosys.specs linker_scripts/peripherals/system_stm32l4xx.c -o system_stm32l4xx.o
# arm-none-eabi-gcc -c -mcpu=cortex-m4 -mthumb -Wall -g -fmessage-length=0 --specs=nosys.specs  main.c -o main.o
# arm-none-eabi-gcc boot_stm32l496xx.o vtable_stm32l496xx.o system_stm32l4xx.o main.o -mcpu=cortex-m4 -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T./linker_scripts/link_stm32l496xx.ld -o main.elf


ib --cfg debug_arm_gcc_assembly linker_scripts/vtable_stm32l496xx.o linker_scripts/boot_stm32l496xx.o
ib --cfg debug_arm_gcc main.o

arm-none-eabi-gcc \
  ../out/debug_arm_gcc_assembly/linker_scripts/boot_stm32l496xx.o \
  ../out/debug_arm_gcc_assembly/linker_scripts/vtable_stm32l496xx.o \
  ../out/debug_arm_gcc/main.o \
  ../out/debug_arm_gcc/linker_scripts/peripherals/system_stm32l4xx.o \
  -mcpu=cortex-m4 \
  -mthumb \
  -Wall \
  --specs=nosys.specs \
  -nostdlib \
  -lgcc \
  -T./linker_scripts/link_stm32l496xx.ld \
  -o \
  ../out/debug_arm_gcc/main.elf

arm-none-eabi-objcopy -S -O binary ../out/debug_arm_gcc/main.elf ../out/debug_arm_gcc/main.bin
arm-none-eabi-size ../out/debug_arm_gcc/main.elf
