all: os-image

run: all
	qemu-system-x86_64 -fda os-image

os-image: boot_sector.bin kernel.bin
	cat $^ > os-image


# KERNEL
kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.o: kernel.c
	i386-elf-gcc -ffreestanding -c $< -o $@

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@


# BOOT SECTOR
boot_sector.bin: boot_sector.asm
	nasm $< -o $@

clean:
	rm *.bin *.o
