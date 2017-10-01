# just to make my life easier.
nasm boot_sector_print.asm -o boot_sector.bin
qemu-system-x86_64 boot_sector.bin
